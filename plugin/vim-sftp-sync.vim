echo "My plugin loaded"

function! SyncFile()
    "let scp_return = system("scp")
    "vsplit __Sftp_Sync_Status__
    "normal! ggdG

    "call append(0, split(scp_return, '\v\n'))
endfunction

function! ObtainServerCredentials()
    let dir_separator = "\\"
    let local_path = getcwd()
    let sync_file = local_path . dir_separator . ".sync"
    if filereadable(sync_file)
        let credentials = readfile(sync_file)
        for cred in credentials
            let splited_cred = split(cred, "=")
            if splited_cred[0] == 'HOST'
                let g:sync_credentials.host = splited_cred[1]
            elseif splited_cred[0] == 'USER'
                let g:sync_credentials.user = splited_cred[1]
            elseif splited_cred[0] == 'PASSWORD'
                let g:sync_credentials.password = splited_cred[1]
            elseif splited_cred[0] == 'TARGET_FOLDER'
                let g:sync_credentials.target_folder = splited_cred[1]
            endif
        endfor
    else
        echo "Sem arquivo de configuração para SFTP"
    endif
endfunction

let g:sync_credentials = {}
call ObtainServerCredentials()
