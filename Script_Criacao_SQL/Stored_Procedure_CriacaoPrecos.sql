CREATE PROCEDURE GeraPrecos
@Preco FLOAT,
@UF VARCHAR(4),
@Produto VARCHAR(max)
AS
DECLARE @PrecoOrig_Psico AS FLOAT 

DECLARE @Preco_Maximo AS FLOAT
DECLARE @Preco_Maximo_Calc AS FLOAT

DECLARE @Preco_Minimo AS FLOAT
DECLARE @Preco_Minimo_Calc AS FLOAT

DECLARE @PASSO AS FLOAT

DECLARE @Preco_1 AS FLOAT
DECLARE @Preco_2 AS FLOAT
DECLARE @Preco_3 AS FLOAT
DECLARE @Preco_4 AS FLOAT
DECLARE @Preco_5 AS FLOAT
DECLARE @Preco_6 AS FLOAT


/* Definindo as variáveis de Preços Máximos, Minímos presentes no conjunto de dados */
SET @Preco_Maximo = (SELECT MAX(PRECO) FROM [dbo].[STAGE_RPO] WHERE PRODUTO = @Produto AND UF = @UF)
SET @Preco_Maximo_Calc = @Preco_Maximo + (@Preco_Maximo * 0.05)

SET @Preco_Minimo = (SELECT MIN(PRECO) FROM [dbo].[STAGE_RPO] WHERE PRODUTO = @Produto AND UF = @UF)
SET @Preco_Minimo_Calc = @Preco_Minimo  - (@Preco_Minimo * 0.05)

SET @Passo = ROUND((@Preco_Maximo - @Preco_Minimo) / 6, 2)

SET @Preco_1 = @Preco_Minimo + @Passo
SET @Preco_1 = (SELECT [dbo].[GeraPsico](@Preco_1))


SET @Preco_2 = @Preco_1 + @Passo
SET @Preco_2 = (SELECT [dbo].[GeraPsico](@Preco_2))

SET @Preco_3 = @Preco_2 + @Passo
SET @Preco_3 = (SELECT [dbo].[GeraPsico](@Preco_3))

SET @Preco_4 = @Preco_3 + @Passo
SET @Preco_4 = (SELECT [dbo].[GeraPsico](@Preco_4))

SET @Preco_5 = @Preco_4 + @Passo
SET @Preco_5 = (SELECT [dbo].[GeraPsico](@Preco_5))

SET @Preco_6 = @Preco_5 + @Passo
SET @Preco_6 = (SELECT [dbo].[GeraPsico](@Preco_6))

SET @PrecoOrig_Psico = (SELECT [dbo].[GeraPsico](@Preco))

INSERT INTO [dbo].[ML_OUTPUT](PRECO_1, PRECO_2, PRECO_3, PRECO_4,
							PRECO_5, PRECO_6,  PRECO_ORIG, PRECO_ORIG_PSICO) VALUES(@Preco_1, @Preco_2, @Preco_3,
																					@Preco_4, @Preco_5, @Preco_6,
																					@Preco, @PrecoOrig_Psico)
GO