def FlagsForFile(filename, **kwargs):
    flags = [
        '-Wall',
        '-Wextra',
        '-Werror'
        '-pedantic',
        '-I',
        '.',
        '-isystem',
        '/usr/include',
        '-xc++',
        '-std=c++11'
    ]

    return {
        'flags': flags,
        'do_cache': True
    }
