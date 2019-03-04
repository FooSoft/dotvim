def FlagsForFile(filename, **kwargs):
    flags = [
        '-Wall',
        '-Wextra',
        '-Werror'
        '-pedantic',
        '-std=c++11'
        '-I',
        '.',
    ]

    return {
        'flags': flags,
        'do_cache': True
    }
