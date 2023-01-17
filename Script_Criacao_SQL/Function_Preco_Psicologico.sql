
CREATE FUNCTION [dbo].[GeraPsico](@Preco FLOAT)
RETURNS FLOAT
AS
BEGIN
	DECLARE @Centavos AS FLOAT
	SET @Centavos = @Preco - FLOOR(@Preco)

	IF (@Centavos > 0.5)
		BEGIN	
			SET @Centavos = 0.99 
			SET @Preco = FLOOR(@Preco) + @Centavos
		END
	ELSE
		SET @Preco = FLOOR(@Preco) - 0.01

	RETURN @Preco
END
GO


