def Settings( **kwargs ):
    return {
      'flags': [ '-x', 'c++', '-Wall', '-Wextra', '-Werror',
                 '-lapue',
                 '-I../include',
                 '-l:libtlpi.a',
                 '-I../lib',
               ],
    }
