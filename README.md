# dnd-knowledge-database-4e
Project to help clarify race and class information for those confused with the mysterious world of 4th edition D&amp;D.

By Ryan Harris and Tyler Moore

INSTALLATION INSTRUCTIONS

# Clone from the repository:
    git clone git@github.com:killerHELIX/dnd-knowledge-database-4e.git
    
# A couple of commands to run in your terminal:
    Get Python Flask:
        sudo easy_install flask markdown
        
    Get Psycopg2:
        sudo apt-get update
        sudo apt-get install python-psycopg2
        
    Get password hashing capability for postgres:
        sudo apt-get install postgresql-contrib-9.3
        
    Get flask-socketio:
        sudo easy_install flask-socketio


#. Starting Postgres Server
    If your sql server is not currently running, execute the following line in your terminal.
    
        sudo service postgresql start

#. Log in to your postgres client. If you do not know how, please refer to the postgres wiki.
        
        https://wiki.postgresql.org/wiki/First_steps
        
#. From the main postgres window, import the dnd.sql file to create a DB called dungeons and populate it.
        
        \i dnd.sql
        