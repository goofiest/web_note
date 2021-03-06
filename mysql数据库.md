mysql笔记

第一天

### 1、连接数据库

命令行连接

~~~sql
mysql -uroot -p123456	-- 连接数据库

update mysql.user set authentication_string=password('123456') where user='root' and Host='localhost';	-- 修改用户密码

flush privileges;	-- 刷新权限

describe 数据表;	-- 显示表中所有信息

~~~

~~~sql
create database 数据库名;	--创建数据库

--		sql 单行注释。
/*多行注释*/	
~~~



### 2、操作数据库

++++

操作数据库>操作数据库中的表>操作数据库表中的数据

##### 2.1操作数据库（了解）

1、创建数据库。

```sql
create database [if not exists] demo;	-- [] 表示可选
```

2、删除数据库。

~~~sql
drop database [if exists] sta1;
~~~

3、使用数据库。

~~~sql
use demo;

--	如果表名或者字段名是一个特殊字符，就需要带``
use `use`;
~~~

4、查看数据库。

~~~sql
show databases;	-- 查看所有的数据库。
~~~



##### 2.2、数据库的数据类型

> 数值

| 类型      |                                            | 字节数              |
| --------- | ------------------------------------------ | ------------------- |
| tinyint   | 十分小的数据                               | 1个字节             |
| smallint  | 较小的数据                                 | 2个字节             |
| mediumint | 中等大小的数据                             | 3个字节             |
| **int**   | **标准的整数**                             | **4个字节**         |
| bigint    | 较大的数据                                 | 8个字节             |
| float     | 浮点数                                     | 4个字节             |
| double    | 浮点数                                     | 8个字节（精度问题） |
| decimal   | 字符串形式的浮点数（金融计算的时候，常用） |                     |

> 字符串

| 类型        |                        | 字节数      |
| ----------- | ---------------------- | ----------- |
| char        | 固定大小的字符串       | 0~255       |
| **varchar** | **可变字符串**         | **0~65535** |
| tinytext    | 微型文本               | 2^8-1       |
| **text**    | **文本串(保存大文本)** | **2^16-1**  |

> 时间日期

| 类型         |                          |                        |
| ------------ | ------------------------ | ---------------------- |
| date         | YYY-MM-DD                | 日期格式               |
| time         | HH: mm: ss               | 时间格式               |
| **datetime** | **YYY-MM-DD HH: mm: ss** | **最常用的时间格式**   |
| timestamp    | 时间戳                   | 1970.1.1到现在的毫秒数 |
| year         | 年份表示                 |                        |

> null

null 表示没有值（空值），未知，**注意：** 不要使用 NULL 进行运算，结果为null



##### 2.3、数据库的字段属性（重点）

* Unsigned：
  * 无符号的整数
  * 声明了该列不能声明为负数

* zerfill:
  * 0填充
  * 不足的位数，使用0来填充。例如：`5 > 005`

* 自增（auto_increment）：

  * 通常理解为自增，自动在上一条记录的基础上+1（默认）

  * 通常用来设置唯一主键（index），必须是整数类型
  * 可以自定义设置主键自增的**起始值**和**步长**

* 默认：

  * 设置默认的值

##### 2.4、创建数据库表（重点）

~~~sql
-- AUTO_INCREMENT 自增
-- 注意最后一行命令后面不需要,(逗号)
-- PRIMARY KEY 主键，一般一个表只有唯一的主键

CREATE TABLE IF NOT EXISTS `student` (
`id` INT(4) NOT NULL AUTO_INCREMENT COMMENT '学号',
`name` VARCHAR(30) NOT NULL DEFAULT '匿名' COMMENT '姓名',
`pwd` VARCHAR(20) NOT NULL  DEFAULT '123456' COMMENT '密码',
PRIMARY KEY(`id`)		-- 设置主键约束
)ENGINE=INNODB DEFAULT CHARSET=utf8		-- 设置字符集
~~~

<font size=4 color=red>格式：</font>

~~~sql
CREATE TABLE [IF NOT EXISTS] `表名`(
	'字段名' 列类型 [属性] [属性] [索引] [注释]，
    '字段名' 列类型 [属性] [属性] [索引] [注释]，
     ··· ···
    '字段名' 列类型 [属性] [属性] [索引] [注释]
)[表类型] [字符集] [注释]
~~~



###### 查看创建语句。

* 查看创建数据库的语句

~~~sql
SHOW CREATE DATABASE 数据库名		-- 记不得命令时可以查看其他数据库是如何创建的
~~~

* 查看数据表的定义语句

~~~sql
SHOW CREATE TABLE 表名 	-- 可以查看该表的创建命令 
~~~

* 查看表的结构

~~~sql
DESC 表名		-- 显示表的结构（以表格的形式展现）
~~~



##### 2.5、修改和删除数据表（重点）

* 修改表名：ALTER TABLE 旧表名 RENAME AS 新表名

~~~sql
ALTER TABLE student RENAME AS student1	-- 修改表名
~~~

* 增加表字段：	ALTER TABLE 表名 ADD 字段名 列属性

~~~sql
ALTER TABLE student1 ADD age INT(4) COMMENT '年龄'
~~~

* 修改表的字段（重命名，修改约束）

~~~sql
-- 字段重命名
ALTER TABLE student1 CHANGE pwd passd  COMMENT '未知'	-- 不能更改约束条件

-- 修改约束
ALTER TABLE student1 MODIFY passd VARCHAR(11) COMMENT '密码' -- 不能字段重命名
~~~

* 删除表字段	ALTER TABLE 表名 DROP 字段名

~~~sql
ALTER TABLE student1 DROP age
~~~

* 删除表	DROP TABLE [IF EXISTS] 表名

~~~sql
DROP TABLE [IF EXISTS] student1
~~~

**所有的创建和删除操作尽量加上判断，以免报错**



 ### 3、MySQL数据库管理

##### 3.1、外键（了解）

~~~sql
ALTER TABLE 表 ADD CONSTRAINT 约束名 FOREIGN KEY(作为外键约束的列) REFERENCES 那个表（那个字段）
~~~

##### 3.2、DML语言（必须记住）

DML语言：数据操作语言

######  插入语句（insert）

  格式：` insert into 表名 (字段名1，字段名2，字段名3) values（'值1'，'值2'，'值3'）`

~~~sql
INSERT INTO `student` (`name`) VALUES('张三')
~~~

注意事项：

* 字段可以省略，但后面的值必须要一一对应。
* 可以同时插入多条数据，VALUES后面的值需要逗号（ , ）隔开。`( ),( )... ...`

###### 修改（update）

~~~sql
--  修改学生姓名，带条件
UPDATE `student` SET `name`='李四' WHERE id=1		-- 将 id=1 的学生姓名改成李四
UPDATE `student` SET `name`='王五',`pwd`='admin' WHERE id=1   -- 修改多条值

--  修改学生姓名，不带条件
UPDATE `student` SET `name`='王五'	-- 将所有学生的姓名改为王五
UPDATE `student` SET `name`='王五',`pwd`='admin'
~~~

条件：where 语句，运算符，id 等于某个值，大于某个值，小于某个值，在某个区间内修改。

| 操作符              | 含义         | 范围  | 结果  |
| ------------------- | ------------ | ----- | ----- |
| =                   | 等于         | 6=9   | false |
| <> 或 !=            | 不等于       |       |       |
| >                   | 大于         |       |       |
| <                   |              |       |       |
| >=                  | 大于等于     |       |       |
| <=                  | 小于等于     |       |       |
| between ... and ... | 在某个范围内 | [2,5] |       |
| and                 | &&           |       |       |
| or                  | \|\| 或      |       |       |

语法：` update 表名 set colnum_name = value,[colnum_name = value,....] where [条件]`

注意：

*  colnum_name 是数据库的列，最好使用` `` `
* 条件如果，没有指定，则会修改所有的列
* value，是一个具体的值，也可以是一个变量。

###### 删除：（delete）

语法：`delete from 表名 [where 条件]`

~~~sql
DELETE FROM `student` WHERE id=1	-- 删除学生表中id=1的学生信息
~~~

~~~sql
TRUNCATE `student` 	-- 清空数据表, 完全清空一个数据库表，表的结构和索引，约束都不会变
~~~



> delete 和 truncate 区别

* 相同点：都能删除数据库，都不会删除数据结构
* 不同点：

    * truncate 重新设置自增列，计数器会归零。
    * truncate 不会影响事务。

### 4、DQL 查询数据（最重要）

* 所有的查询操作都用它**Select**
* 简单的查询，复杂的查询他都可以做。
* **数据库中最核心的语言，最重要的语言**
* 使用频率最高的语言。 

#### 4.1、指定查询字段



语法：`select 字段，.... from 表`

~~~sql
-- 查询全部学生	select 字段 from 表
SELECT * FROM `text`

-- 查询指定字段
SELECT `name` , `id` FROM `text`

-- 别名，给结果起个别名 AS 可以给字段起别名，也可以给表起别名
SELECT `name` AS 姓名 ,`id` AS 学号 FROM `text`
~~~



**去重** `distinct`

作用：去除 select 查询出来的结果中重复的数据，重复数据只显示一条。

~~~sql
SELECT DISTINCT `id` AS 学号 FROM `text`	-- 查看哪些学生参加考试，通过学号查询
~~~



**扩展**

~~~sql
SELECT VERSION()	-- 查询系统版本（函数）

SELECT 9*9+9 AS 计算结果 	-- 用来计算（表达式）

SELECT @@auto_increment_increment	-- 查询自增的步长
~~~



#### 4.2、where 条件子句。

作用：检索数据中**符合条件**的值。

##### （1）、逻辑运算符

| 运算符       | 语法                   | 描述                             |
| ------------ | ---------------------- | -------------------------------- |
| and  或 &&   | a and b     a&&b       | 逻辑与（两个都为真，结果为真）   |
| or  或  \|\| | a or b        a \|\| b | 逻辑或（其中一个为真，结果为真） |
| Not   或   ! | not a           ！a    | 逻辑非（真为假，假为真）         |

~~~sql
-- 查询 age 在20~23 之间
SELECT `id`,`age` FROM `text` WHERE `age`>=20 AND `age`<=23	
~~~

~~~sql
-- 查询 age 在20~23 之间
SELECT `id`,`age` FROM `text` WHERE `age` BETWEEN 20 AND 23
~~~



##### （2）、模糊查询

| 运算符      | 描述                                                    | 语法                |
| ----------- | ------------------------------------------------------- | ------------------- |
| is null     | 如果操作符为**null** ,结果为真。                        | a is null           |
| is not null | 如果操作符**不为null** ，结果为真                       | a is not null       |
| between     | 若 a 在 b 和 c 之间                                     | a between b and c   |
| **like**    | SQL 匹配，如果a匹配b，则结果为真                        | a like b            |
| **in**      | 假设 a 在 a1，或者a2 ..... 其中的某一个值中，则结果为真 | a in(a1,a2,a3.....) |

**扩展：** 在 like中 % （代表0到任意字符）  _(表示一个字符) 

~~~sql
-- 查询姓韩的所有同学
SELECT `id` , `name` FROM `text` WHERE `name` LIKE '韩%'

-- 查询姓韩的同学，名字后面只有一个字
SELECT `id` , `name` FROM `text` WHERE `name` LIKE '韩_' 	
~~~



#### 4.3、联表查询





### 5、mysql函数

#### 5.1、常用函数

**用法：** select 函数名(实参)  [from 表名]；



##### （1）数学运算

~~~sql
-- 绝对值
SELECT ABS(-8) -- 结果：8

-- 向上取整
SELECT CEILING(9.23) -- 结果：10

-- 向下取整
SELECT FLOOR(9.8) -- 结果：9

-- 返回一个 0~1 之间的随机数
SELECT RAND()

-- 判断一个数的符号
SELECT SIGN(8)	-- 结果：1
SELECT SIGN(0)	-- 结果：0
SELECT SIGN(-8) -- 结果：-1
~~~



##### （2）字符串函数

~~~sql
-- 判断字符串的长度
SELECT CHAR_LENGTH('曲终人散')	-- 结果：4

-- 拼接字符串
SELECT CONCAT('h','e','l','l','o') -- 结果:hello

-- 大写转化成小写
SELECT LOWER('Hello,Java') -- 结果:hello,java

-- 小写转化成大写
SELECT UPPER('java')  -- 结果:JAVA
~~~



#### 5.2、聚合函数









