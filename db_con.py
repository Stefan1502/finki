from sqlalchemy import create_engine
from sshtunnel import SSHTunnelForwarder
# generating copies from all the tables
def create_copies():
    year = 2015
    for x in range(5):
        engine.execute(f'create table copy_{year} as (select * from measurements_{year}_import);')
        year += 1
# deleting all the copies
def delete_copies():
    year = 2015
    for x in range(5):
        engine.execute(f'drop table copy_{year};')
        year += 1
# generating copies, then execute the .sql file containing all the alterations
# and creating an all in one table, deleting the rest
def create_all_in_one_table():
    create_copies()
    with open('db_alterations.sql', 'r') as s:
        sql_script = s.read()
        conn = engine.connect()
        trans = conn.begin()
        conn.execute(sql_script)
        trans.commit()
        conn.close()

ssh_tunnel = SSHTunnelForwarder(
    ssh_address_or_host='',
    ssh_username="",
    ssh_password="",
    remote_bind_address=('localhost', 5432))
ssh_tunnel.start()
engine = create_engine(f'postgresql://baza@localhost:{ssh_tunnel.local_bind_port}/pollution',
                       connect_args={'options': '-csearch_path=pollution'})
if engine:
    print("yes")