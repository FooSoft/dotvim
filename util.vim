auto BufRead,BufNewFile *.gohtml setfiletype html

function! s:unalign() range
    for l:line in range(a:firstline, a:lastline)
        let l:text = getline(l:line)
        let l:subst = substitute(l:text, '\(\S\+\)\s\{2,}', '\1 ', 'g')
        call setline(l:line, l:subst)
    endfor
endfunction

command! -range UnAlign <line1>,<line2>call s:unalign()

function! s:guid()
    if has('pythonx')
        pythonx import uuid
        let l:guid = pyxeval('str(uuid.uuid4())')
    elseif has('windows')
        let l:guid = system('powershell.exe -command "[guid]::NewGuid().ToString()"')[:-2]
    endif
    if exists('l:guid')
        execute 'normal! i' . l:guid . "\<Esc>"
    else
        echoerr 'No GUID provider available'
    endif
endfunction

command! Guid call s:guid()

if has('nvim')
lua << EOF

function _G.put(...)
    local objects = {}
    for i = 1, select('#', ...) do
        local v = select(i, ...)
        table.insert(objects, vim.inspect(v))
    end

    print(table.concat(objects, '\n'))
    return ...
end

function _G.list_packages()
    for key, value in pairs(package.loaded) do
        print(key)
    end
end

EOF
endif
