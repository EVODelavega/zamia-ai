#!/usr/bin/env python
# -*- coding: utf-8 -*- 

#
# Copyright 2017 Guenter Bartsch
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Lesser General Public License for more details.
# 
# You should have received a copy of the GNU Lesser General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#
# NLP Macro Expansion Engine
#
# persists named macros in our DB (macros are global that way, all macros available in all modules)
# generates all possible macro-expansions of macro-expressions
#

import os
import sys
import logging
import re
import unittest
import json
from copy import copy

from nltools import misc
from nltools.tokenizer import tokenize
from zamiaprolog.errors import PrologError

import model

class NLPMacroEngine(object):

    def __init__(self, session):

        self.named_macros = {}
        self.session      = session

    def define_named_macro(self, name, mappings, module_name, location):
        if not name in self.named_macros:
            self.named_macros[name] = []
        self.named_macros[name].extend(mappings)

        # persist in DB

        nlpm = self.session.query(model.NLPMacro).filter(model.NLPMacro.name==name).first()
        if nlpm:

            if nlpm.module != module_name:
                raise PrologError('macro %s defined in more than one module: %s vs %s' % (name, module_name, nlpm.module), location)

            nlpm.mappings = json.dumps(self.named_macros[name])
        else:
            nlpm = model.NLPMacro (module   = module_name,
                                   name     = name,
                                   mappings = json.dumps(self.named_macros[name]),
                                   location = str(location))
            self.session.add(nlpm)

    def lookup_named_macro (self, name, location):

        if not name in self.named_macros:
            nlpm = self.session.query(model.NLPMacro).filter(model.NLPMacro.name==name).first()
            if not nlpm:
                raise PrologError('undefined macro %s' % name, location)

            self.named_macros[name] = json.loads(nlpm.mappings)

        return self.named_macros[name]

    def macro_expand(self, lang, nlp_input, response, location):

        logging.debug ('macro_expand: nlp_input=%s, response=%s' % (repr(nlp_input), repr(response)))

        # handle implicit macros

        implicit_macros = {}

        nlp_input2 = ''

        i = 0
        while i<len(nlp_input):

            if nlp_input[i] == '(':

                j = nlp_input[i+1:].find(')')
                if j<0:
                    raise Exception (') missing')
                j += i

                # extract macro

                macro_s = nlp_input[i+1:j+1]

                # print "macro_s: %s" % macro_s

                macro_name = '__INTERNAL_MACRO_%06d__' % len(implicit_macros)

                implicit_macros[macro_name] = []
                for s in macro_s.split('|'):
                    implicit_macros[macro_name].append({'w': s.strip()})

                nlp_input2 += '@' + macro_name + ':w '

                i = j+2
            else:

                nlp_input2 += nlp_input[i]
                i+=1

        # print "implicit macros: %s" % repr(implicit_macros)

        # extract all macros used

        macro_names = set()

        # print nlp_input

        for pos, char in enumerate(nlp_input2):

            if char == '@':

                macro = re.match(r'@([A-Z0-9_]+):', nlp_input2[pos:])

                # print "MACRO:", macro.group(1)

                macro_names.add(macro.group(1))

        # print "macro names used: %s" % macro_names

        # generate all macro-expansions

        macro_names = sorted(macro_names)
        todo        = [ (0, {}) ]
        discourses  = []

        while True:

            if len(todo) == 0:
                break

            idx, mappings = todo.pop(0)

            if idx < len(macro_names):

                macro_name = macro_names[idx]

                macro = implicit_macros[macro_name] if macro_name in implicit_macros else self.lookup_named_macro(macro_name, location)

                for v in macro:

                    new_mappings = copy(mappings)
                    new_mappings[macro_name] = v

                    todo.append ( (idx+1, new_mappings) )

            else:

                # generate discourse_round for this set of mappings

                # print 'mappings:', repr(mappings)

                s = nlp_input2
                p = response

                # print s,p

                for k in mappings:

                    for v in mappings[k]:

                        s = s.replace('@'+k+':'+v, mappings[k][v])
                        p = p.replace('@'+k+':'+v, mappings[k][v])

                inp_raw = misc.compress_ws(s.lstrip().rstrip())
                p       = misc.compress_ws(p.lstrip().rstrip())

                inp_tokenized = ' '.join(tokenize(inp_raw, lang))

                discourse = (inp_tokenized, p)
                discourses.append(discourse)

                logging.debug ('macro_expand:    discourse : %s' % (repr(discourse)))

        return discourses

class TestMacroEngine (unittest.TestCase):

    def setUp(self):
        pass

    def testLocalMacros(self):

        me = NLPMacroEngine()
        me.macro_expand('de', [u'(HAL,|Computer,|Du,|) (Ich bin|Ich fühle mich|Man bin ich|Da bin ich) (zufrieden|so zufrieden|glücklich|so glücklich|froh|so froh)'],[u''])

if __name__ == "__main__":

    unittest.main()

