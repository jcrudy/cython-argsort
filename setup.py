from distutils.core import setup
from distutils.extension import Extension
import sys
import numpy

#Determine whether to use Cython
if '--cythonize' in sys.argv:
    cythonize_switch = True
    del sys.argv[sys.argv.index('--cythonize')]
else:
    cythonize_switch = False

#Find all includes
numpy_include = numpy.get_include()

#Set up the ext_modules for Cython or not, depending
if cythonize_switch:
    from Cython.Distutils import build_ext
    from Cython.Build import cythonize
    ext_modules = cythonize([Extension("cyargsort.argsort", ["cyargsort/argsort.pyx"],include_dirs = [numpy_include])])
else:
    ext_modules = [Extension("cyargsort.argsort", ["cyargsort/argsort.c"],include_dirs = [numpy_include])]
    
#Create a dictionary of arguments for setup
setup_args = {'name':'cyargsort',
    'version':'0.1.0',
    'author':'Jason Rudy',
    'author_email':'jcrudy@gmail.com',
    'packages':['parallel',],
    'license':'LICENSE.txt',
    'description':'Argsort in Cython',
    'long_description':open('README.md','r').read(),
    'py_modules' : [],
    'ext_modules' : ext_modules,
    'classifiers' : ['Development Status :: 3 - Alpha'],
    'requires':[]} 

#Add the build_ext command only if cythonizing
if cythonize_switch:
    setup_args['cmdclass'] = {'build_ext': build_ext}

#Finally
setup(**setup_args)
