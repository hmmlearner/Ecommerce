IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231207074307_InitialCreate')
BEGIN
    CREATE TABLE [Categories] (
        [Id] int NOT NULL IDENTITY,
        [Name] nvarchar(max) NOT NULL,
        [DisplayOrder] int NOT NULL,
        [CreatedDateTime] datetime2 NOT NULL,
        CONSTRAINT [PK_Categories] PRIMARY KEY ([Id])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231207074307_InitialCreate')
BEGIN
    CREATE TABLE [Customers] (
        [Id] int NOT NULL IDENTITY,
        [Name] nvarchar(max) NOT NULL,
        [Email] nvarchar(max) NULL,
        [StreetAddress] nvarchar(max) NULL,
        [City] nvarchar(max) NULL,
        [State] nvarchar(max) NULL,
        [PostalCode] nvarchar(max) NULL,
        CONSTRAINT [PK_Customers] PRIMARY KEY ([Id])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231207074307_InitialCreate')
BEGIN
    CREATE TABLE [Products] (
        [Id] int NOT NULL IDENTITY,
        [Title] nvarchar(max) NOT NULL,
        [Description] nvarchar(max) NULL,
        [SKU] nvarchar(max) NOT NULL,
        [Price] float NOT NULL,
        [SalePrice] float NOT NULL,
        [WasPrice] float NOT NULL,
        [ImageUrl] nvarchar(max) NULL,
        [CategoryId] int NOT NULL,
        CONSTRAINT [PK_Products] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_Products_Categories_CategoryId] FOREIGN KEY ([CategoryId]) REFERENCES [Categories] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231207074307_InitialCreate')
BEGIN
    CREATE INDEX [IX_Products_CategoryId] ON [Products] ([CategoryId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231207074307_InitialCreate')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20231207074307_InitialCreate', N'7.0.14');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231209021922_Customer Updates')
BEGIN
    ALTER TABLE [Customers] ADD [IsAdmin] int NOT NULL DEFAULT 0;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231209021922_Customer Updates')
BEGIN
    ALTER TABLE [Customers] ADD [Password] varbinary(max) NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231209021922_Customer Updates')
BEGIN
    ALTER TABLE [Customers] ADD [Saltkey] varbinary(max) NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231209021922_Customer Updates')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20231209021922_Customer Updates', N'7.0.14');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231209034606_Customer Updates Identity Id column')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20231209034606_Customer Updates Identity Id column', N'7.0.14');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231209075823_Customer and product Updates added timelines')
BEGIN
    ALTER TABLE [Products] ADD [CreatedDate] datetime2 NOT NULL DEFAULT '0001-01-01T00:00:00.0000000';
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231209075823_Customer and product Updates added timelines')
BEGIN
    ALTER TABLE [Customers] ADD [CreatedDate] datetime2 NOT NULL DEFAULT '0001-01-01T00:00:00.0000000';
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231209075823_Customer and product Updates added timelines')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20231209075823_Customer and product Updates added timelines', N'7.0.14');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231209102534_Category and product Updated relationship')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20231209102534_Category and product Updated relationship', N'7.0.14');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231210110943_Category and product Updated relationship2')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20231210110943_Category and product Updated relationship2', N'7.0.14');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231210111554_Category and product Updated relationship4')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20231210111554_Category and product Updated relationship4', N'7.0.14');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231210115115_Category and product Updated relationship5')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20231210115115_Category and product Updated relationship5', N'7.0.14');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231210121159_Category and product Updated relationship6')
BEGIN
    ALTER TABLE [Products] DROP CONSTRAINT [FK_Products_Categories_CategoryId];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231210121159_Category and product Updated relationship6')
BEGIN
    DROP INDEX [IX_Products_CategoryId] ON [Products];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231210121159_Category and product Updated relationship6')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20231210121159_Category and product Updated relationship6', N'7.0.14');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231210122053_Category and product Updated relationship7')
BEGIN
    CREATE INDEX [IX_Products_CategoryId] ON [Products] ([CategoryId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231210122053_Category and product Updated relationship7')
BEGIN
    ALTER TABLE [Products] ADD CONSTRAINT [FK_Products_Categories_CategoryId] FOREIGN KEY ([CategoryId]) REFERENCES [Categories] ([Id]) ON DELETE CASCADE;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231210122053_Category and product Updated relationship7')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20231210122053_Category and product Updated relationship7', N'7.0.14');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231211013412_ShoppingCart and ShoppingCartItems')
BEGIN
    CREATE TABLE [ShoppingCarts] (
        [Id] int NOT NULL IDENTITY,
        CONSTRAINT [PK_ShoppingCarts] PRIMARY KEY ([Id])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231211013412_ShoppingCart and ShoppingCartItems')
BEGIN
    CREATE TABLE [ShoppingCartItems] (
        [Id] int NOT NULL IDENTITY,
        [Quantity] int NOT NULL,
        [ProductId] int NOT NULL,
        [CustomerId] int NOT NULL,
        [ShoppingCartId] int NULL,
        CONSTRAINT [PK_ShoppingCartItems] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_ShoppingCartItems_Customers_CustomerId] FOREIGN KEY ([CustomerId]) REFERENCES [Customers] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_ShoppingCartItems_Products_ProductId] FOREIGN KEY ([ProductId]) REFERENCES [Products] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_ShoppingCartItems_ShoppingCarts_ShoppingCartId] FOREIGN KEY ([ShoppingCartId]) REFERENCES [ShoppingCarts] ([Id])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231211013412_ShoppingCart and ShoppingCartItems')
BEGIN
    CREATE INDEX [IX_ShoppingCartItems_CustomerId] ON [ShoppingCartItems] ([CustomerId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231211013412_ShoppingCart and ShoppingCartItems')
BEGIN
    CREATE INDEX [IX_ShoppingCartItems_ProductId] ON [ShoppingCartItems] ([ProductId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231211013412_ShoppingCart and ShoppingCartItems')
BEGIN
    CREATE INDEX [IX_ShoppingCartItems_ShoppingCartId] ON [ShoppingCartItems] ([ShoppingCartId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231211013412_ShoppingCart and ShoppingCartItems')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20231211013412_ShoppingCart and ShoppingCartItems', N'7.0.14');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231211020419_ShoppingCart and ShoppingCartItems 1')
BEGIN
    ALTER TABLE [ShoppingCartItems] DROP CONSTRAINT [FK_ShoppingCartItems_Customers_CustomerId];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231211020419_ShoppingCart and ShoppingCartItems 1')
BEGIN
    DROP INDEX [IX_ShoppingCartItems_CustomerId] ON [ShoppingCartItems];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231211020419_ShoppingCart and ShoppingCartItems 1')
BEGIN
    DECLARE @var0 sysname;
    SELECT @var0 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[ShoppingCartItems]') AND [c].[name] = N'CustomerId');
    IF @var0 IS NOT NULL EXEC(N'ALTER TABLE [ShoppingCartItems] DROP CONSTRAINT [' + @var0 + '];');
    ALTER TABLE [ShoppingCartItems] DROP COLUMN [CustomerId];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231211020419_ShoppingCart and ShoppingCartItems 1')
BEGIN
    ALTER TABLE [ShoppingCarts] ADD [CustomerId] int NOT NULL DEFAULT 0;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231211020419_ShoppingCart and ShoppingCartItems 1')
BEGIN
    CREATE INDEX [IX_ShoppingCarts_CustomerId] ON [ShoppingCarts] ([CustomerId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231211020419_ShoppingCart and ShoppingCartItems 1')
BEGIN
    ALTER TABLE [ShoppingCarts] ADD CONSTRAINT [FK_ShoppingCarts_Customers_CustomerId] FOREIGN KEY ([CustomerId]) REFERENCES [Customers] ([Id]) ON DELETE CASCADE;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231211020419_ShoppingCart and ShoppingCartItems 1')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20231211020419_ShoppingCart and ShoppingCartItems 1', N'7.0.14');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231213091930_Orders and Orders_shoppingcart')
BEGIN
    ALTER TABLE [ShoppingCartItems] ADD [Order_ShoppingCartId] int NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231213091930_Orders and Orders_shoppingcart')
BEGIN
    CREATE TABLE [Orders] (
        [OrderNumber] int NOT NULL IDENTITY,
        [CustomerId] int NOT NULL,
        [PhoneNumber] nvarchar(max) NOT NULL,
        [ShippingName] nvarchar(max) NOT NULL,
        [ShippingStreetAddress] nvarchar(max) NOT NULL,
        [ShippingCity] nvarchar(max) NOT NULL,
        [ShippingState] nvarchar(max) NOT NULL,
        [ShippingPostCode] nvarchar(max) NOT NULL,
        [ShippingCountry] nvarchar(max) NULL,
        [OrderTotal] float NOT NULL,
        [OrderDate] datetime2 NOT NULL,
        [ShippingMethod] int NOT NULL,
        CONSTRAINT [PK_Orders] PRIMARY KEY ([OrderNumber]),
        CONSTRAINT [FK_Orders_Customers_CustomerId] FOREIGN KEY ([CustomerId]) REFERENCES [Customers] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231213091930_Orders and Orders_shoppingcart')
BEGIN
    CREATE TABLE [Orders_ShoppingCart] (
        [Id] int NOT NULL IDENTITY,
        [OrderNumber] int NOT NULL,
        CONSTRAINT [PK_Orders_ShoppingCart] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_Orders_ShoppingCart_Orders_OrderNumber] FOREIGN KEY ([OrderNumber]) REFERENCES [Orders] ([OrderNumber]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231213091930_Orders and Orders_shoppingcart')
BEGIN
    CREATE INDEX [IX_ShoppingCartItems_Order_ShoppingCartId] ON [ShoppingCartItems] ([Order_ShoppingCartId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231213091930_Orders and Orders_shoppingcart')
BEGIN
    CREATE INDEX [IX_Orders_CustomerId] ON [Orders] ([CustomerId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231213091930_Orders and Orders_shoppingcart')
BEGIN
    CREATE INDEX [IX_Orders_ShoppingCart_OrderNumber] ON [Orders_ShoppingCart] ([OrderNumber]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231213091930_Orders and Orders_shoppingcart')
BEGIN
    ALTER TABLE [ShoppingCartItems] ADD CONSTRAINT [FK_ShoppingCartItems_Orders_ShoppingCart_Order_ShoppingCartId] FOREIGN KEY ([Order_ShoppingCartId]) REFERENCES [Orders_ShoppingCart] ([Id]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231213091930_Orders and Orders_shoppingcart')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20231213091930_Orders and Orders_shoppingcart', N'7.0.14');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231213093226_Orders and Orders_shoppingcart2')
BEGIN
    ALTER TABLE [ShoppingCartItems] DROP CONSTRAINT [FK_ShoppingCartItems_Orders_ShoppingCart_Order_ShoppingCartId];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231213093226_Orders and Orders_shoppingcart2')
BEGIN
    DROP TABLE [Orders_ShoppingCart];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231213093226_Orders and Orders_shoppingcart2')
BEGIN
    DROP INDEX [IX_ShoppingCartItems_Order_ShoppingCartId] ON [ShoppingCartItems];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231213093226_Orders and Orders_shoppingcart2')
BEGIN
    DECLARE @var1 sysname;
    SELECT @var1 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[ShoppingCartItems]') AND [c].[name] = N'Order_ShoppingCartId');
    IF @var1 IS NOT NULL EXEC(N'ALTER TABLE [ShoppingCartItems] DROP CONSTRAINT [' + @var1 + '];');
    ALTER TABLE [ShoppingCartItems] DROP COLUMN [Order_ShoppingCartId];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231213093226_Orders and Orders_shoppingcart2')
BEGIN
    CREATE TABLE [OrderLines] (
        [Id] int NOT NULL IDENTITY,
        [OrderNumber] int NOT NULL,
        [ProductId] int NOT NULL,
        [count] int NOT NULL,
        [price] float NOT NULL,
        CONSTRAINT [PK_OrderLines] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_OrderLines_Orders_OrderNumber] FOREIGN KEY ([OrderNumber]) REFERENCES [Orders] ([OrderNumber]) ON DELETE CASCADE,
        CONSTRAINT [FK_OrderLines_Products_ProductId] FOREIGN KEY ([ProductId]) REFERENCES [Products] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231213093226_Orders and Orders_shoppingcart2')
BEGIN
    CREATE INDEX [IX_OrderLines_OrderNumber] ON [OrderLines] ([OrderNumber]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231213093226_Orders and Orders_shoppingcart2')
BEGIN
    CREATE INDEX [IX_OrderLines_ProductId] ON [OrderLines] ([ProductId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231213093226_Orders and Orders_shoppingcart2')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20231213093226_Orders and Orders_shoppingcart2', N'7.0.14');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231213121356_Orders and Orders_shoppingcart3')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20231213121356_Orders and Orders_shoppingcart3', N'7.0.14');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231214230001_Updated order and orderline tables')
BEGIN
    ALTER TABLE [OrderLines] DROP CONSTRAINT [FK_OrderLines_Orders_OrderNumber];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231214230001_Updated order and orderline tables')
BEGIN
    DECLARE @var2 sysname;
    SELECT @var2 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[OrderLines]') AND [c].[name] = N'OrderNumber');
    IF @var2 IS NOT NULL EXEC(N'ALTER TABLE [OrderLines] DROP CONSTRAINT [' + @var2 + '];');
    ALTER TABLE [OrderLines] ALTER COLUMN [OrderNumber] int NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231214230001_Updated order and orderline tables')
BEGIN
    ALTER TABLE [OrderLines] ADD CONSTRAINT [FK_OrderLines_Orders_OrderNumber] FOREIGN KEY ([OrderNumber]) REFERENCES [Orders] ([OrderNumber]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231214230001_Updated order and orderline tables')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20231214230001_Updated order and orderline tables', N'7.0.14');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231214231711_altered customer table')
BEGIN
    ALTER TABLE [Customers] ADD [Country] nvarchar(max) NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231214231711_altered customer table')
BEGIN
    ALTER TABLE [Customers] ADD [Phone] nvarchar(max) NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20231214231711_altered customer table')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20231214231711_altered customer table', N'7.0.14');
END;
GO

COMMIT;
GO

