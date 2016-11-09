# dnd-knowledge-database-4e
Project to help clarify race and class information for those confused with the mysterious world of 4th edition D&amp;D.

By Ryan Harris and Tyler Moore

INSTALLATION INSTRUCTIONS

[RYAN, PLEASE PLACE WEBDEV SETUP INSTRUCTIONS HERE, WE NEED THEM FOR THE SPRINT. INCLUDE GIT CLONE LINE TO ENSURE THAT USER HAS THE SAME SET UP AS US.]

#. Starting Postgres Server
    If your sql server is not currently running, execute the following line in your terminal.
    
        sudo service postgresql start

#. Log in to your postgres client. If you do not know how, please refer to the postgres wiki.
        
        https://wiki.postgresql.org/wiki/First_steps
        
#. From the main postgres window, import the dnd.sql file to create a DB called dungeons and populate it.
        
        \i dnd.sql
        