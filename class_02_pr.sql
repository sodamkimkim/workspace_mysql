desc membertbl;
select * from membertbl;

update membertbl
set memberAddress = '부산시';

insert into membertbl
values ("kim","김소담","부산시");

insert into membertbl
(memberId, memberName, memberAddress)
values ("kim2","김소담2","서울시");

select *
from membertbl
where memberId = "kim2";

select memberName
from membertbl
where memberid = "kim2";

delete
from membertbl
where memberid = "kim2";
select * from membertbl;

update membertbl
set memberaddress = "서울시"
where memberid = "김소담";

