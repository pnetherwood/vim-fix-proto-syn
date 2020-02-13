au BufRead,BufNewFile * if getline(1) =~ '^8=FIX.' | setlocal ft=fix | endif 
