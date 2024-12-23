# dotbackup
function dotbackup 
    # Check if the 'clean' flag is passed
    if test (count $argv) = 0
        echo "No file path specified."
        return
        
    else if test $argv[1] = 'clean'
        # Clean backups
        if test (count $argv) -lt 2
            echo "No file specified for cleaning."
            return
        end

        if test $argv[2] = 'all'
            set backups $(find $HOME/.dotbackup/bak -type f -name '*.bak')
            for backup in $backups
                if test -f $HOME/.dotbackup/bak/og_comma_bak.csv
                    grep -v ,$backup $HOME/.dotbackup/bak/og_comma_bak.csv > $HOME/.dotbackup/bak/temp.csv; mv $HOME/.dotbackup/bak/temp.csv $HOME/.dotbackup/bak/og_comma_bak.csv
                end
                rip $backup
                echo "Deleted backup: $backup"
            end
        else
            set backups $(find $HOME/.dotbackup/bak -type f -name $(basename $argv[2])'*.bak')
            for backup in $backups
                if test -f $HOME/.dotbackup/bak/og_comma_bak.csv
                    grep -v ,$backup $HOME/.dotbackup/bak/og_comma_bak.csv > $HOME/.dotbackup/bak/temp.csv; mv $HOME/.dotbackup/bak/temp.csv $HOME/.dotbackup/bak/og_comma_bak.csv
                end
                rip $backup
                echo "Deleted backup: $backup"
            end
        end
        return

    else if test $argv[1] = 'push'
        # Push backups
        set og_path $(pwd)
        cd $HOME/.dotbackup
        if ! test -d $HOME/.dotbackup/.git
            git init
            git remote add origin https://github.com/linhtutkyawdev/.dotbackup.git
        end
        git checkout -b bak
        git add .
        git commit -m "Backup update"$(date +'%m_%d_%Y_%H_%M_%S')
        git push origin bak
        cd $og_path
        return
        
    
    else if test $argv[1] = 'pull'
        # Pull backups
        set og_path $(pwd)
        cd $HOME/.dotbackup
        if ! test -d $HOME/.dotbackup/.git
            git init
            git remote add origin https://github.com/linhtutkyawdev/.dotbackup.git
        end
        git checkout -b bak
        git pull origin bak
        cd $og_path
        return

    else if test $argv[1] = 'list'
        # List backups
        if ! test -f $HOME/.dotbackup/bak/og_comma_bak.csv
            echo "No backups found."        
        else    
            bat $HOME/.dotbackup/bak/og_comma_bak.csv
        end
        return

    #  Check version
    else if test $argv[1] = 'version'
        echo "dotbackup version 1.0.0"
        return

    # restore with linenumber
     else if test $argv[1] = 'restore'
        if test (count $argv) -lt 2
            echo "Please provide the line number."
            return
        end

        if ! test -f $HOME/.dotbackup/bak/og_comma_bak.csv
            echo "No backups found."
            return
        end

        if test $argv[2] = 'all'
            for i in $(seq 1 $(wc -l < $HOME/.dotbackup/bak/og_comma_bak.csv))
                set fields $(string split ',' $(sed -n $i'p' $HOME/.dotbackup/bak/og_comma_bak.csv))
                cp $fields[2] $fields[1]
                echo Coppied $fields[2] to $fields[1]
            end
        else
            set fields $(string split ',' $(sed -n $argv[2]'p' $HOME/.dotbackup/bak/og_comma_bak.csv))
            cp $fields[2] $fields[1]
            echo Coppied $fields[2] to $fields[1]
        end
        return
    end

    # Check if the file exists
    if ! test -f $argv[1]
        echo "File path does not exist."
        return
    end

    # Check and create backup directory and file if they do not exist
    if ! test -f $HOME/.dotbackup/bak/og_comma_bak.csv
        if ! test -d $HOME/.dotbackup/bak
            mkdir $HOME/.dotbackup/bak
        end
        touch $HOME/.dotbackup/bak/og_comma_bak.csv
    end

    # Construct the backup path while maintaining directory structure
    set backup_file_path $HOME/.dotbackup/bak/$(basename $argv[1]).(date +'%m_%d_%Y_%H_%M_%S').bak
    echo (realpath $argv[1]),$backup_file_path >> $HOME/.dotbackup/bak/og_comma_bak.csv

    cp $argv[1] $backup_file_path
    echo "Backup completed!"
end