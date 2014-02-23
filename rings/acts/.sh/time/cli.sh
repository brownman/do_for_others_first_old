#! /usr/bin/python

import locale
import gettext
import os
import sys
from optparse import OptionParser


share_dirs = os.environ.get('XDG_BASE_PDATA', 
                            '/usr/local/share:/usr/share').split(os.pathsep)

BASEDIR = ''
for path in share_dirs:
    if (os.path.exists('%s/clicompanion/'%path)):
        BASEDIR = '%s/clicompanion/'%path
        print "Using locale in system"
        break
if not BASEDIR:
    BASEDIR = os.path.abspath(os.path.dirname(os.path.realpath(sys.argv[0])))
    if (os.path.exists(BASEDIR)):
        print "ERROR: locales dir not found."
        sys.exit(1)
    print "Using locale in source code folder"


parser = OptionParser(usage="%prog [-f] [-q]", version="%prog 1.1")
parser.add_option("-f", "--file", dest="conffile",
                  help="Configuration file to use.", metavar="FILE")
parser.add_option("-c", "--cheatsheet", dest="cheatsheet",
                  help="Read cheatsheet from FILE", metavar="FILE")
parser.add_option("-d", "--debug", dest="debug", action='store_true',
                  default=False, help="Print debug messages",)

(options, args) = parser.parse_args()


def get_language():
    """Return the language to be used by the system.

    If it finds the system language in the translated files, it
    returns it, otherwise it just returns None.
    """
    loc = locale.setlocale(locale.LC_ALL, "")
    loc = loc[:2]
    traducidos = os.listdir(locale_dir)
    if loc in traducidos:
        return loc
    return
    

locale_dir = os.path.join(BASEDIR, "locale")
gettext.install('clicompanion', locale_dir, unicode=True)
idioma = get_language()
if idioma is not None:
    mo = os.path.join(locale_dir, '%s/LC_MESSAGES/clicompanion.mo' % idioma)
    if not os.access(mo, os.F_OK):
        raise IOError("The l10n directory (for language %r) exists but "
                      "not the clicompanion.mo file" % idioma)
    trans = gettext.translation('clicompanion', locale_dir, languages=[idioma])
    trans.install(unicode=True)


if __name__ == "__main__":
    from clicompanionlib.view import run
    run( options )
