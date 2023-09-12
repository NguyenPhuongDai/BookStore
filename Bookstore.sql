use master

go
CREATE DATABASE Bookstore

go
use Bookstore

go
create table [Role]
(
	[id] varchar(3) primary key,
	[name] nvarchar(50) not null unique
)

go
create table [User]
(
	[id] int identity(1,1) primary key,
	[username] varchar(50) not null unique,
	[password] varchar(50) not null,
	[roleId] varchar(3) not null,
	[email] varchar(100),
	[phoneNumber] varchar(11),
	[firstname] nvarchar(50) not null,
	[lastname] nvarchar(50) not null,
	[birthday] date,
	[address] nvarchar(255),
	[departmentId] varchar(5) not null
)

go

go
create table [Department]
(
	[id] varchar(5) primary key,
	[name] nvarchar(100) not null,
	[setUpDate] date,
	[address] nvarchar(255),
	[manager] int
)

alter table [User] add 
		constraint fk_user_role foreign key(roleId) references [Role](id),
		constraint fk_user_department foreign key([departmentId]) references [Department](id)
go
alter table [Department] add 
		constraint fk_department_manage foreign key(manager) references [User](id)

go
create table [Author]
(
	[id] int identity(1,1) primary key,
	[name] nvarchar(200) not null,
	[description] ntext
)

go
create table [Book]
(
	[id] int identity(1,1) primary key,
	[name] nvarchar(200) not null,
	[authorId] int not null,
	[year] int,
	[description] ntext,
	[price] int,
	[amount] int,
	unique ([name], authorId)
)

go
create table [Category]
(
	[id] int identity(1,1) primary key,
	[category] nvarchar(50) not null
)

go
create table [BookCategory]
(
	bookId int not null foreign key references [Book](id),
	categoryId int not null foreign key references [Category](id),
	constraint pk_bookcategory primary key (bookId, categoryId)
)

go
create table [Order]
(
	[id] int identity(1,1) primary key,
	[staffId] int not null,
	[customer] nvarchar(200),
	[phoneNumber] varchar(11),
	[email] varchar(100),
	[address] nvarchar(255),
	[orderDay] date default current_timestamp,
	[totalCoin] int,
	[status] bit not null
)

go
create table [OrderBook]
(
	[orderId] int not null,
	[bookId] int not null,
	[amount] int not null,
	constraint pk_orderbook primary key (orderId, bookId)
)

go
alter table [Book] add 
		constraint fk_book_author foreign key(authorId) references [Author](id)

go
alter table [Order] add 
		constraint fk_order_staff foreign key(staffId) references [User](id)

go
alter table [OrderBook] add
		constraint fk_order_book_order foreign key(orderId) references [Order](id),
		constraint fk_order_book_book foreign key(bookId) references [Book](id)

go
insert into [Role] (id, name) values
('R01', N'Quản lý'),
('R02', N'Nhân viên'),
('R03', N'Người đọc')

go
insert into [Department] values
('PC1A1', N'Phòng A.01 CS.1', '2022-11-25', N'An Dương Vương, Quận 5, Tp.HCM', null),
('PC1A2', N'Phòng A.02 CS.1', '2022-11-25', N'An Dương Vương, Quận 5, Tp.HCM', null),
('PC1A3', N'Phòng A.03 CS.1', '2022-11-25', N'An Dương Vương, Quận 5, Tp.HCM', null),
('PC1B1', N'Phòng B.01 CS.1', '2022-11-25', N'An Dương Vương, Quận 5, Tp.HCM', null),
('PC1B2', N'Phòng B.02 CS.1', '2022-11-25', N'An Dương Vương, Quận 5, Tp.HCM', null),
('PC2A1', N'Phòng A.01 CS.2', '2022-11-25', N'An Dương Vương, Quận 5, Tp.HCM', null)


go
insert into [User] (username, [password], [roleId], email, phoneNumber, firstname, lastname, birthday, [address], departmentId) values
('huutan', '123456', 'R01', 'htan@gmail.com', '0123456789', N'Nguyễn', N'Hữu Tân', null, null, 'PC1A1'),
('phamnam', '123456', 'R01', 'phuongnam@gmail.com', '0121456789', N'Phạm', N'Phương Nam', '2002-05-02', N'Quận Gò Vấp, Tp.HCM', 'PC1A1'),
('phuongdai', '123456', 'R01', 'phuongdai@gmail.com', '0125456789', N'Nguyễn', N'Phương Đại', null, null, 'PC1A1'),
('ngoctran', '123456', 'R01', 'ngoctran@gmail.com', '0923456789', N'Nguyễn', N'Ngọc Trân', null, null, 'PC1A1'),
('nhatriet', '123456', 'R01', 'nhatriet@gmail.com', '0933456789', N'Nhã', N'Triết', null, null, 'PC1A1')

go
insert into [Category] (category) values
(N'Tiểu thuyết'),
(N'Truyện ngắn'),
(N'Truyện dài'),
(N'Truyện ký cách mạng'),
(N'Khoa học'),
(N'Ngôn tình'),
(N'Kinh tế - Chính trị')

go
insert into [Author] ([name], [description]) values
(N'Nam Cao', N'Nam Cao (1915 hoặc 1917[1] – 28 tháng 11 năm 1951) là một nhà văn và cũng là một chiến sĩ, liệt sĩ người Việt Nam. Ông là nhà văn hiện thực lớn (trước Cách mạng Tháng Tám), một nhà báo kháng chiến (sau Cách mạng), một trong những nhà văn tiêu biểu nhất thế kỷ 20. Nam Cao có nhiều đóng góp quan trọng đối với việc hoàn thiện phong cách truyện ngắn và tiểu thuyết Việt Nam ở nửa đầu thế kỷ 20.'),
(N'Thạch Lam', N'Thạch Lam (1910[1]-1942), tên thật là Nguyễn Tường Vinh, là một nhà văn Việt Nam thuộc nhóm Tự Lực văn đoàn. Ông là em ruột của hai nhà văn khác cũng trong nhóm Tự Lực văn đoàn là Nhất Linh và Hoàng Đạo. Ngoài bút danh Thạch Lam, ông còn có các bút danh là Việt Sinh, Thiện Sỹ.')

go
insert into [Book] ([name], authorId, [year], [description], [price], [amount]) values
(N'Truyện người hàng xóm', 1, 1944, N'Truyện người hàng xóm là một câu chuyện kể về cuộc đời của cậu bé tên Hiền kể từ ngày theo mẹ bỏ làng lên phố kiếm ăn cho đến khi từ giã cuộc đời trong bạo bệnh. Chuyện gợi mở, dẫn dắt nhiều hơn là miêu tả dài dòng. Có những đoạn đáng ra người viết khác có thể làm bật lên sự trớ trêu đến thành nghiệt ngã của số phận, với Nam Cao chỉ là nửa trang viết như một lời kể chuyện không hơn. Nhưng cái tài của nhà kể chuyện bậc thầy là ở chỗ đó, người ta chỉ cần có thế cũng đủ hình dung ra cả một cảnh đời. Câu chuyện kết thúc buồn nhưng không u ám, lóe lên cái hy vọng về một đời sống tốt hơn của 2 con người trẻ tuổi, trong những giọt nước mắt khóc cho cái chết của người bạn thân - chàng trai Hiền xấu số. Mời các bạn đón đọc Truyện người hàng xóm.', 100000, 750),
(N'Sống mòn', 1, 1944, N'xuất bản năm 1956 của Nam Cao', 100000, 1500),
(N'Hai đứa trẻ', 2, null, N'', 100000, 2000),
(N'Gió lạnh đầu mùa', 2, 1938, N'', 100000, 1000)

go
insert into [BookCategory] values
(1, 1),
(2, 1),
(3, 2),
(4, 2)

/* Phòng ban */
go 
create proc USP_Query_Department
as
begin
select d.id, d.[name] as [Tên phòng], d.manager as [Trưởng phòng], d.[address] as [Địa chỉ], d.setUpDate as [Ngày thành lập]
from Department d
end

go
create proc USP_Query_DepartmentByName
@department nvarchar(100)
as
begin
select d.id, d.[name] as [Tên phòng], d.manager as [Trưởng phòng], d.[address] as [Địa chỉ], d.setUpDate as [Ngày thành lập]
from Department d
where d.[name] = N''+@department
end

go
create proc USP_Mutation_UpdateManager
@department nvarchar(100),
@nameManager nvarchar(101)
as
begin
update [Department] set
manager = case when isnull((
	select id 
	from [User] u
	where u.firstname + ' ' + u.lastname = N''+ @nameManager
	), 0) != 0 then (
	select id 
	from [User] u
	where u.firstname + ' ' + u.lastname = N''+ @nameManager
	) else null end
where [Department].[name] = N''+@department
end


/* Vai trò */
go 
create proc USP_Query_Role
as
begin
select r.id, r.[name] as [Vai trò]
from [Role] r
end

/* User */
go
create proc USP_Query_Users
as
begin
select [User].id, [User].firstname + ' ' + [User].lastname as [Họ tên], [User].email, [User].phoneNumber as [Số điện thoại], [User].birthday as [Ngày sinh], [User].[address] as [Địa chỉ],
[Role].[name] as [Vai trò], d.[name] as [Phòng Ban]
from [User] join [Role] on ([User].roleId = [Role].id) join [Department] d on d.id = [User].departmentId
end

go
create proc USP_Query_User
@id int
as
begin
select [User].id, [User].firstname + ' ' + [User].lastname as [Họ tên], [User].email, [User].phoneNumber as [Số điện thoại], [User].birthday as [Ngày sinh], [User].[address] as [Địa chỉ],
[Role].[name] as [Vai trò], d.[name] as [Phòng Ban]
from [User] join [Role] on ([User].roleId = [Role].id) join [Department] d on d.id = [User].departmentId
where [User].id = @id
end

/* Login */
go
create proc USP_Mutation_Login
@username varchar(50), @password varchar(50)
as
begin
select top 1 [User].*, [Role].[name] as [role] into #TemporaryTable
from [User] join [Role] on [User].roleId = [Role].id
where [User].username = @username and [User].[password] = @password
alter table #TemporaryTable drop column [password]
select * from #TemporaryTable 
drop table #TemporaryTable
end

/* ------ Đổi thông tin ------- */
go 
create proc USP_Query_CheckPassword
@id int,
@password varchar(50)
as
begin
select count(id) as [cnt]
from [User]
where id = @id and [password] = @password
end

go

create proc USP_Mutation_UpdateUser
@id int,
@firstname nvarchar(50) ,
@lastname nvarchar(50) ,
@email varchar(100),
@phoneNumber varchar(11),
@password varchar(50),
@address nvarchar(255),
@birthday date,
@department nvarchar(100)
as
begin
declare @ids table (id varchar(5));
insert into @ids (id)
select id
from [Department] d
where d.[name] = N'' + @department
update [User] set
firstname = N'' + @firstname,
lastname = N'' + @lastname,
email = @email,
phoneNumber = @phoneNumber,
[password] = case when @password = '' then [password] else @password end,
[address] = @address,
departmentId = case when isnull((select id from @ids) ,'null') != 'null' then (select id from @ids) else departmentId end,
birthday = @birthday
where id = @id
end

go

create proc USP_Query_Search_Users
@role nvarchar(50),
@email varchar(100),
@phoneNumber varchar(11),
@firstname nvarchar(50),
@lastname nvarchar(50),
@address nvarchar(255),
@department nvarchar(100)
as
begin
select @firstname = N'%' + @firstname + '%'
select @lastname = N'%' + @lastname + '%'
select @email = '%' + @email + '%'
select @phoneNumber = '%' + @phoneNumber + '%'
select @address = N'%' + @address + '%'
select @department = N'' + @department
select @role = N'' + @role
select u.id, u.firstname + ' ' + u.lastname as [Họ tên], u.email, u.phoneNumber as [Số điện thoại], u.birthday as [Ngày sinh], u.[address] as [Địa chỉ], r.[name] as [Vai trò],
d.[name] as [Phòng Ban]
from [User] u join [Role] r on r.id = u.roleId join [Department] d on d.id = u.departmentId
where u.firstname like @firstname and u.lastname like @lastname and (u.email like @email or isnull(u.email, 'null') = 'null') 
and (u.phoneNumber like @phoneNumber or isnull(u.phoneNumber, 'null') = 'null')
and (u.[address] like @address or isnull(u.[address], 'null') = 'null') and r.[name] = @role and (d.[name] = @department or isnull(@department, 'null') = 'null' or @department = '')
end

go
create proc USP_Mutation_AddUser
@username varchar(50),
@password varchar(50),
@roleId varchar(3),
@email varchar(100),
@phoneNumber varchar(11),
@firstname nvarchar(50),
@lastname nvarchar(50),
@birthday date,
@address nvarchar(255),
@department nvarchar(100)
as
begin
insert into [User] (username, [password], roleId, [email], [phoneNumber], firstname, lastname, birthday, [address], [departmentId]) values
(@username, @password, @roleId, @email, @phoneNumber, N''+@firstname, N''+@lastname, @birthday, N''+@address, case when isnull((
	select id
	from [Department] d
	where d.[name] = N''+@department
), 'null') != 'null' then (select id
	from [Department] d
	where d.[name] = N''+@department)
	else 'PC1A1' end
)
end

go 
create proc Check_ExistAccount
@account varchar(50)
as
begin
select id
from [User]
where username = @account
end



go
create proc USP_Query_Categories
as
begin
select id, category as [Thể loại]
from [Category]
end

go
create proc USP_Query_Categorie
@name nvarchar(50)
as
begin
select id, category as [Thể loại]
from [Category]
where category = N'' + @name
end





/* Sách */
go
create proc USP_Query_Books
as
begin
select b.id, b.[name] as [Tên truyện], auth.[name] as [Tác giả] , c.category as [Thể loại], b.price as [Giá], b.amount as [Số lượng]
from [Book] b join [BookCategory] bc on b.Id = bc.BookId join [Category] c on bc.CategoryId = c.id join [Author] auth on auth.id = b.authorId
end

go
create proc USP_Query_Book
@id int
as
begin
select b.id, b.[name] as [Tên truyện], auth.[name] as [Tác giả], b.[year] as [Năm], c.category as [Thể loại], b.[description] as [Mô tả], b.price as [Giá], b.amount as [Số lượng]
from [Book] b join [BookCategory] bc on b.Id = bc.BookId join [Category] c on bc.CategoryId = c.id join [Author] auth on auth.id = b.authorId
where b.id = @id
end

/* Tìm sách */
go
create proc USP_Query_Books_Search
@name nvarchar(200) = '',
@author nvarchar(200) = '',
@category nvarchar(50) = ''
as
begin
select @name = N'%' + @name + '%'
select b.id, b.[name] as [Tên truyện],auth.[name] as [Tác giả] , c.category as [Thể loại], b.price as [Giá], b.amount as [Số lượng]
from [Book] b join [BookCategory] bc on b.Id = bc.BookId join [Category] c on bc.CategoryId = c.id join [Author] auth on auth.id = b.authorId
where (c.category = @category and (auth.[name] like @author or (@author = '' or @author = N'Tất cả')) and b.[name] like @name )
or ((@category = '' or N''+@category = N'Tất cả') and (auth.[name] like @author or (@author = '' or @author = N'Tất cả')) and b.[name] like @name)
end

/* Thêm sách */
go
create proc USP_Mutation_AddBook
@name nvarchar(200),
@authorId int,
@description ntext = '',
@year int = null,
@price int = 0,
@amount int = 0,
@categoryId int = null
as
begin
declare @ids table (id int);
insert into [Book] ([name], authorId, [description], [year], price, amount)
output inserted.id into @ids
values 
(@name, @authorId, @description, @year, @price, @amount)
insert into [BookCategory] (categoryId,  bookId) values
(@categoryId, (select id from @ids))
end

/* Sửa sách */
go
create proc USP_Mutation_UpdateBook
@id int,
@name nvarchar(200),
@author nvarchar(200),
@description ntext,
@year int,
@price int,
@amount int,
@categoryId int = null
as
begin
if isnull((
	select a.id
	from [Book] b join [Author] a on b.authorId = a.id 
	where b.id != @id and a.[name] = N''+@author and b.[name] = N''+@name
), 0) != 0
	begin
		return
	end
update [Book] set
[name] = N''+@name,
[authorId] = case when isnull((
select top 1 [Author].id
from [Author]
where [Author].[name] = N''+@author), 0) != 0 then (
select top 1 [Author].id
from [Author]
where [Author].[name] = N''+@author) else [authorId] end,
[description] = @description,
[year] = @year,
[price] = @price,
[amount] = @amount
where [Book].id = @id
if isnull(@categoryId, 0) != 0
update [BookCategory] set
[categoryId] = @categoryId
where [BookCategory].bookId = @id
end

exec dbo.USP_Mutation_UpdateBook @id = 15, @name = [New Book], @author = [Nam Cao], @description = [Test UpDate], @year = [0], @price = [100000], @amount = [15], @categoryId = 1

go 
create proc Delete_Book
@bookId int
as
begin TRANSACTION
		if isnull((select top 1 OrderBook.bookId from [OrderBook] where bookId = @bookId ), 0) = 0
		begin
			delete from [BookCategory] where [BookCategory].bookId = @bookId
			delete from [Book] where [Book].id = @bookId
			IF @@ROWCOUNT = 0
			BEGIN
				ROLLBACK TRANSACTION
				RETURN
			END
		end
commit TRANSACTION

/* 
	exec dbo.Delete_Book @bookId = 2
*/


/*------------------------------ Thanh toán ------------------------------*/
/* insert Order */
go
create proc USP_Mutation_Order
@staffId int,
@customer nvarchar(200),
@phoneNumber varchar(11),
@email varchar(100),
@address nvarchar(255),
@totalCoin int,
@status bit
as
begin
declare @inserted_ids table ([id] int);
insert into [Order] (staffId, customer, phoneNumber, email, [address],totalCoin, [status])
output inserted.[id] into @inserted_ids
values
(@staffId, @customer, @phoneNumber, @email, @address, @totalCoin,@status)
select [Order].id
from [Order]
where [Order].id = (select id from @inserted_ids)
end

/* inser OrderBook */
go
create proc USP_Mutation_Order_Book
@orderId int,
@bookId int,
@amount int
as
begin
insert into [OrderBook] (orderId, bookId, amount)
values
(@orderId, @bookId, @amount)
end

/* update amount */
go
create proc USP_Mutation_MinusNumberOfBooks
@bookId int,
@amount int
as
begin
update [Book] set
amount = amount - @amount
where id = @bookId
end
/*-----------------------------------------------------------------------*/

go
create proc USP_Query_Orders
as
begin
select o.id, o.staffId as [id Nhân viên], o.customer as [Khách hàng], o.phoneNumber as [Số điện thoại], o.email, o.[address] as [Địa chỉ], o.orderDay as [Ngày mua], o.totalCoin as [Tổng tiền], o.[status] as [Trạng thái thanh toán]
from [Order] o
order by id desc
end

go
create proc USP_Query_Order_Book
@orderId int
as
begin
select b.id, b.[name] as [Tên sách], auth.[name] as [Tác giả], b.price as [giá], ob.amount as [Số lượng]
from [OrderBook] ob join Book b on ob.bookId = b.id join [Author] auth on b.authorId = auth.id
where ob.orderId = @orderId
end

go
create proc USP_Mutation_Update_Order
@orderId int,
@customer nvarchar(200),
@phoneNumber varchar(11),
@email varchar(100),
@address nvarchar(255),
@status bit
as
begin
select @customer = N'' + @customer
select @address = N'' + @address
update [Order] set
customer = @customer,
phoneNumber = @phoneNumber,
email = @email,
[address] = @address,
[status]=@status
where id = @orderId
end

go
create proc USP_Query_Auths
as
begin
select a.id, a.[name] as [Tác giả]
from [Author] a
end

go
create proc USP_Query_Auth
@name nvarchar(200)
as
begin
select a.id, a.[name] as [Tác giả], a.[description] as [Mô tả]
from [Author] a
where a.[name] = N''+ @name
end

go
create proc Mutation_Add_Auth
@name nvarchar(200),
@description ntext
as
begin
insert into [Author] ([name], [description]) values
(@name, @description)
end

go
create proc Mutation_Delete_Auth
@id int
as
begin TRANSACTION
	declare @ids table ([i] int not null identity(1,1),id varchar(5));
	insert into @ids (id)
	select id
	from Book
	where authorId = @id

	declare @cnt int
	set @cnt = (select top 1 COUNT(id) from @ids)

	while (@cnt > 0)
		begin
			if isnull((select top 1 OrderBook.bookId from [OrderBook] where bookId = (select top 1 id from @ids where i = @cnt) ), 0) != 0
				begin 
					ROLLBACK TRANSACTION
					RETURN
				end
			set @cnt = @cnt - 1
		end
	declare @cnt2 int
	set @cnt2 = (select top 1 COUNT(id) from @ids)
	while (@cnt2 > 0)
		begin
			if isnull((select top 1 OrderBook.bookId from [OrderBook] where bookId = (select top 1 id from @ids where i = @cnt2) ), 0) = 0
				begin 
					delete
					from BookCategory
					where bookId = (select top 1 id from @ids where i = @cnt2)
				end
			set @cnt2 = @cnt2 - 1
		end

	delete
	from Book
	where authorId = @id
	delete 
	from Author
	where id = @id
commit TRANSACTION

go
create proc Check_Exists_Book
@name nvarchar(200),
@author nvarchar(200)
as
begin
select b.id
from Book b join Author a on b.authorId = a.id
where b.[name] = N''+@name and a.[name] = N''+@author
end

create proc USP_Query_Orders_test
as
begin
select o.id, o.staffId as [id Nhân viên], o.customer as [Khách hàng], o.phoneNumber as [Số điện thoại], o.email, o.[address] as [Địa chỉ], o.orderDay as [Ngày mua], o.totalCoin as [Tổng tiền], o.[status] as [Trạng thái thanh toán]
from [Order] o
order by id desc
end

/*
Phòng ban: 
	- exec dbo.USP_Query_Department
	- exec dbo.USP_Query_DepartmentByName @department = 'Phòng A.01 CS.1'
	- exec dbo.USP_Mutation_UpdateManager @department, @nameManager

Vai trò: exec dbo.USP_Query_Role

Users: 
	- exec dbo.USP_Query_Users
	- exec dbo.USP_Query_User @id = 2
	

Login: exec dbo.USP_Mutation_Login @username = [phamnam], @password = [123456]

Đổi thông tin:
	- Check Password cũ: exec dbo.USP_Query_CheckPassword @id = [ ], @password = [ ]
	- Đổi tt: exec dbo.USP_Mutation_UpdateUser @id = [ ], @firstname = [ ], @lastname = [ ], @email = [ ], @phoneNumber = [ ], @password = [ ],
		@address = [ ], @birthday = null , @department = ''

Tìm kiếm user: exec dbo.USP_Query_Search_Users @role = [Nhân viên] , @email = '' , @phoneNumber = '', 
	@firstname = '' , @lastname = '', @address = '' , @department = ''

Thêm user: exec dbo.USP_Mutation_AddUser @username, @password, @email, @phoneNumber, @firstname, @lastname, @birthday, @address, @department

Check account tồn tại: exec dbo.Check_ExistAccount @account

Thể loại sách: 
	- exec dbo.USP_Query_Categories
	- exec dbo.USP_Query_Categorie @name = [Truyện ngắn]

Sách: 
	- exec dbo.USP_Query_Books
	- exec dbo.USP_Query_Book @id = 1

	Tìm sách: exec dbo.USP_Query_Books_Search @name = [ ], @author = [ ], @category = ''

	Check exists: exec dbo.Check_Exists_Book @name, @auth

	Thêm sách: exec dbo.USP_Mutation_AddBook @name = 'New Book', @authorId = 1, @description = 'New Book', @price = 50000, @amount = 100 , @categoryId = 3

	Sửa sách: exec dbo.USP_Mutation_UpdateBook @id = 5, @name = [New Book 2], @author = [Nam Cao], @description = [Update book], @year = [2022], @price = 10000, @amount = 15

	Xóa sách: exec dbo.Delete_Book @bookId = 2

Tác giả: 
	- exec dbo.USP_Query_Auths
	- exec dbo.USP_Query_Auth @name = [Nam Cao]

	Thêm tác giả: exec dbo.Mutation_Add_Auth @name, @description
	Xóa tác giả: exec dbo.Mutation_Delete_Auth @id = 2

Thanh toán: 
	- Thêm hóa đơn: exec dbo.USP_Mutation_Order @staffId = 4, @customer = '', @phoneNumber = null, @email = null, @address =null, @totalCoin = 10000
	- Thêm sách vào hóa đơn: exec dbo.USP_Mutation_Order_Book @orderId = 1, @bookId = null, @amount = 20
	- Cập nhật số lượng sách: exec dbo.USP_Mutation_MinusNumberOfBooks @bookId = 1, @amount = 100

hóa đơn:
	exec dbo.USP_Query_Orders
	exec dbo.USP_Query_Order_Book @orderId
	- Sửa thông tin khách hàng: exec dbo.USP_Mutation_Update_Order @orderId = 3, @customer = "Khách C", @phoneNumber = "0904296887", @email = '', @address = ''
*/