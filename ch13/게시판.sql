create table boarde{
num number(20) not null primary key,
writer varchar2(15),
email varchar2(30),
subject varchar2(75),
passwd varchar2(12) not null,
reg_date timestamp not null,
readcount number not null,
ref number(20) not null,
re_step number(10) not null,
re_level number(10) not null,
content varchar2(3000) not null,
ip varchar2(20) not null,
filename varchar2(500));

desc boarde;
select * from boarde;

create TABLE member(
id VARCHAR2(15) PRIMARY KEY not null,
passwd VARCHAR2(12) not null,
date_number VARCHAR2(15),
email VARCHAR2(30),
address VARCHAR2(25),
tel VARCHAR2(13),
name VARCHAR2(15) not null,
reg_date TIMESTAMP not null);

/
CREATE or REPLACE PROCEDURE pro_insert_id
is
    v_passwd login.passwd%type:='aaa';
    v_name login.name%type;
    v_cnt number := 0;
begin
    DBMS_OUTPUT.PUT_LINE('pro_insert_id 시작');
    for e in (select writer from boarde group by writer) loop
        SELECT COUNT(*) into v_cnt from login where id=e.writer;
        DBMS_OUTPUT.put_line('v_cnt: '||v_cnt);
        if v_cnt=0 then
            dbms_output.put_line('writer: '||e.writer);
            insert into login (id, passwd, name, reg_date) VALUES (e.writer, v_passwd,
            e.writer, current_timestamp);
        end if;
    end loop;
    commit;
end;
/
EXECUTE pro_insert_id;
/
select * from member order by num DESC, ref ASC;

insert into member(id, passwd, name, reg_date) values ('admin', 'admin', '관리자', CURRENT_TIMESTAMP);

commit;