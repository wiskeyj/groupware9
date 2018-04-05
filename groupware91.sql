SET SESSION FOREIGN_KEY_CHECKS=0;


/* Create Tables */

-- 날짜
CREATE TABLE COM_DATE
(
	CDNO bigint NOT NULL AUTO_INCREMENT COMMENT '번호',
	CDDATE char(10) COMMENT '날짜',
	CDYEAR char(4) COMMENT '년도',
	CDMM char(2) COMMENT '월',
	CDDD char(2) COMMENT '일',
	CDWEEKOFYEAR smallint COMMENT 'WEEKOFYEAR',
	CDWEEKOFMONTH smallint COMMENT 'WEEKOFMONTH',
	CDWEEK smallint COMMENT 'WEEK',
	CDDAYOFWEEK smallint COMMENT 'DAYOFWEEK',
	PRIMARY KEY (CDNO),
	UNIQUE (CDNO)
) COMMENT = '날짜';


-- 부서
CREATE TABLE COM_DEPT
(
	DEPTNO int(10) NOT NULL COMMENT '부서코드',
	DEPTNM varchar(20) COMMENT '부서명',
	PRIMARY KEY (DEPTNO)
) COMMENT = '부서';


-- 사용자
CREATE TABLE COM_USER
(
	USERNO int(10) NOT NULL COMMENT '사용자번호',
	USERNM varchar(20) COMMENT '사용자명',
	PRIMARY KEY (USERNO)
) COMMENT = '사용자';


-- 보낸메일
CREATE TABLE EML_SEND
(
	ESNO int(10) NOT NULL AUTO_INCREMENT COMMENT '발송번호',
	ESTITLE varchar(50) COMMENT '제목',
	ESTO varchar(50) COMMENT '받는사람',
	ESCC varchar(1000) COMMENT '참조',
	ESBCC varchar(1000) COMMENT '숨은참조',
	ESCONTENTS text COMMENT '내용',
	USERNO int(10) NOT NULL COMMENT '사용자번호',
	PRIMARY KEY (ESNO),
	UNIQUE (ESNO)
) COMMENT = '보낸메일';


-- 첨부파일
CREATE TABLE EML_SENDFILE
(
	FILENO int(10) NOT NULL AUTO_INCREMENT COMMENT '파일번호',
	FILENAME varchar(100) COMMENT '파일명',
	REALNAME varchar(30) COMMENT '실제파일명',
	FIELSIZE int(10) COMMENT '파일크기',
	ESNO int(10) NOT NULL COMMENT '발송번호',
	PRIMARY KEY (FILENO),
	UNIQUE (FILENO),
	UNIQUE (ESNO)
) COMMENT = '첨부파일';


-- 일정상세
CREATE TABLE SCH_DETAIL
(
	SSNO int(10) NOT NULL COMMENT '일정번호',
	SDSEQ smallint NOT NULL COMMENT '순번',
	SDDATE date COMMENT '날짜',
	SDHOUR char(2) COMMENT '시간',
	SDMINUTE char(2) COMMENT '분',
	PRIMARY KEY (SSNO, SDSEQ),
	UNIQUE (SSNO, SDSEQ)
) COMMENT = '일정상세';


-- 공휴일
CREATE TABLE SCH_HOLIDAY
(
	SHNO smallint NOT NULL AUTO_INCREMENT COMMENT '번호',
	SHTITLE varchar(20) COMMENT '공휴일명',
	SHMONTH smallint COMMENT '월',
	SHDATE smallint COMMENT '일',
	SHCOLOR varchar(10) COMMENT '색상',
	DELETEFLAG char(1) COMMENT '삭제',
	PRIMARY KEY (SHNO),
	UNIQUE (SHNO)
) COMMENT = '공휴일';


-- 일정
CREATE TABLE SCH_SCHEDULE
(
	SSNO int(10) NOT NULL AUTO_INCREMENT COMMENT '일정번호',
	SSTITLE varchar(50) COMMENT '일정명',
	SSTYPE char(1) COMMENT '구분',
	SSSTARTDATE char(10) COMMENT '시작일',
	SSSTARTHOUR char(2) COMMENT '시작일-시간',
	SSSTARTMINUTE char(2) COMMENT '시작일-분',
	SSENDDATE varchar(10) COMMENT '종료일',
	SSENDHOUR char(2) COMMENT '종료일-시간',
	SSENDMINUTE char(2) COMMENT '종료일-분',
	SSREPEATTYPE char(1) COMMENT '반복',
	SSREPEATOPTION varchar(2) COMMENT '반복옵션',
	SSREPEATEND varchar(10) COMMENT '반복종료',
	SSCONTENTS text COMMENT '내용',
	SSISOPEN char(1) COMMENT '공개여부',
	UPDATEDATE datetime COMMENT '수정일자',
	INSERTDATE datetime COMMENT '작성일자',
	USERNO int(10) NOT NULL COMMENT '사용자번호',
	DELETEFLAG char(1) COMMENT '삭제',
	PRIMARY KEY (SSNO),
	UNIQUE (SSNO)
) COMMENT = '일정';


-- 결재문서
CREATE TABLE SGN_DOC
(
	DOCNO bigint NOT NULL AUTO_INCREMENT COMMENT '문서번호',
	DOCTITLE varchar(50) COMMENT '제목',
	DOCCONTENTS text COMMENT '문서내용',
	DELETEFLAG char(1) COMMENT '삭제여부',
	DOCSTATUS char(1) COMMENT '문서상태',
	DOCSTEP smallint COMMENT '결재단계',
	DTNO int NOT NULL COMMENT '문서양식번호',
	UPDATEDATE datetime COMMENT '수정일자',
	INSERTDATE datetime COMMENT '작성일자',
	USERNO int(10) NOT NULL COMMENT '사용자번호',
	DEPTNM varchar(20) COMMENT '부서명',
	DOCSIGNPATH varchar(200) COMMENT '결재경로문자열',
	PRIMARY KEY (DOCNO),
	UNIQUE (DOCNO)
) COMMENT = '결재문서';


-- 첨부파일
CREATE TABLE SGN_DOCFILE
(
	FILENO int(10) NOT NULL AUTO_INCREMENT COMMENT '파일번호',
	FILENAME varchar(100) COMMENT '파일명',
	REALNAME varchar(30) COMMENT '실제파일명',
	FIELSIZE int(10) COMMENT '파일크기',
	DOCNO bigint NOT NULL COMMENT '문서번호',
	PRIMARY KEY (FILENO),
	UNIQUE (FILENO)
) COMMENT = '첨부파일';


-- 문서양식종류
CREATE TABLE SGN_DOCTYPE
(
	DTNO int NOT NULL AUTO_INCREMENT COMMENT '문서양식번호',
	DTTITLE varchar(30) COMMENT '문서양식명',
	DTCONTENTS text COMMENT '문서양식내용',
	DELETEFLAG char(1) COMMENT '삭제',
	PRIMARY KEY (DTNO),
	UNIQUE (DTNO)
) COMMENT = '문서양식종류';


-- 결재경로
CREATE TABLE SGN_PATH
(
	SPNO int NOT NULL AUTO_INCREMENT COMMENT '결재경로번호',
	SPTITLE varchar(30) COMMENT '경로명',
	INSERTDATE date COMMENT '생성일자',
	USERNO int(10) NOT NULL COMMENT '사용자번호',
	SPSIGNPATH varchar(200) COMMENT '결재경로문자열',
	PRIMARY KEY (SPNO),
	UNIQUE (SPNO)
) COMMENT = '결재경로';


-- 결재경로상세-결재자
CREATE TABLE SGN_PATHUSER
(
	SPNO int NOT NULL COMMENT '결재경로번호',
	SPUSEQ int NOT NULL COMMENT '경로순번',
	USERNO int(10) NOT NULL COMMENT '사용자번호',
	SSTYPE char(1) COMMENT '결재종류',
	PRIMARY KEY (SPNO, SPUSEQ),
	UNIQUE (SPNO)
) COMMENT = '결재경로상세-결재자';


-- 결재
CREATE TABLE SGN_SIGN
(
	SSNO int(10) NOT NULL AUTO_INCREMENT COMMENT '결재번호',
	DOCNO bigint NOT NULL COMMENT '문서번호',
	SSSTEP smallint COMMENT '결재단계',
	SSTYPE char(1) COMMENT '결재종류',
	SSRESULT char(1) COMMENT '결재결과',
	SSCOMMENT varchar(1000) COMMENT '코멘트',
	RECEIVEDATE datetime COMMENT '받은일자',
	SIGNDATE datetime COMMENT '결재일자',
	USERNO int(10) NOT NULL COMMENT '사용자번호',
	USERPOS varchar(10) COMMENT '직위',
	PRIMARY KEY (SSNO, DOCNO),
	UNIQUE (SSNO, DOCNO)
) COMMENT = '결재';



