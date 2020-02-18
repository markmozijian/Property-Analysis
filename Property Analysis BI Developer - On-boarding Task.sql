--a.	Display a list of all property names and their property id¡¯s for Owner Id: 1426
SELECT p.Id AS PropertyId
      ,p.Name AS PropertyName
FROM [Keys].[dbo].[OwnerProperty] op
INNER JOIN [dbo].[Property] p ON op.PropertyId = p.Id
WHERE op.OwnerId = 1426

--b.	Display the current home value for each property in question a). 
SELECT p.Id AS PropertyId
      ,p.Name AS PropertyName
	  ,phv.Value AS HomeValue
FROM [Keys].[dbo].[OwnerProperty] op
INNER JOIN [dbo].[Property] p ON op.PropertyId = p.Id
INNER JOIN [dbo].[PropertyHomeValue]  phv ON op.PropertyId = phv.PropertyId
WHERE op.OwnerId = 1426 AND phv.HomeValueTypeId=1

/*c.	For each property in question a), return the following:                                                                      
i.	Using rental payment amount, rental payment frequency, tenant start date and tenant end date to write a query that returns the sum of all payments from start date to end date. 
ii.	Display the yield. */

SELECT 
	  CASE
    WHEN [PaymentFrequencyId] = 1 THEN DATEDIFF(WEEK, tp.StartDate, tp.EndDate)*tp.PaymentAmount
    WHEN [PaymentFrequencyId] = 2 THEN DATEDIFF(WEEK, tp.StartDate, tp.EndDate)*tp.PaymentAmount/2
	WHEN [PaymentFrequencyId] = 3 THEN DATEDIFF(MONTH, tp.StartDate, tp.EndDate)*tp.PaymentAmount
    ELSE NULL
END AS Yield
FROM [Keys].[dbo].[OwnerProperty] op
INNER JOIN [dbo].[Property] p ON op.PropertyId = p.Id
INNER JOIN [dbo].[PropertyHomeValue]  phv ON op.PropertyId = phv.PropertyId
INNER JOIN [Keys].[dbo].[TenantProperty] tp ON op.PropertyId = tp.PropertyId
WHERE op.OwnerId = 1426 AND phv.HomeValueTypeId=1

--d.	Display all the jobs available in the marketplace (jobs that owners have advertised for service suppliers). 

SELECT *
FROM [dbo].[Job] j
WHERE j.JobStatusId =1


SELECT 
	  CASE
    WHEN [PaymentFrequencyId] = 1 THEN DATEDIFF(WEEK, tp.StartDate, tp.EndDate)*tp.PaymentAmount
    WHEN [PaymentFrequencyId] = 2 THEN DATEDIFF(WEEK, tp.StartDate, tp.EndDate)*tp.PaymentAmount/2
	WHEN [PaymentFrequencyId] = 3 THEN DATEDIFF(MONTH, tp.StartDate, tp.EndDate)*tp.PaymentAmount
    ELSE NULL
END AS Yield
FROM [Keys].[dbo].[OwnerProperty] op
INNER JOIN [dbo].[Property] p ON op.PropertyId = p.Id
INNER JOIN [dbo].[PropertyHomeValue]  phv ON op.PropertyId = phv.PropertyId
INNER JOIN [Keys].[dbo].[TenantProperty] tp ON op.PropertyId = tp.PropertyId
WHERE op.OwnerId = 1426 AND phv.HomeValueTypeId=1

--e.	Display all property names, current tenants first and last names and rental payments per week/ fortnight/month for the properties in question a).

SELECT p.Name AS PropertyName
	,pe.FirstName AS TenantFirstName
	,pe.LastName AS TenantLastName
	,tp.PaymentAmount
	,tpf.Name AS PaymentFrequency
FROM [dbo].[Property] p 
INNER JOIN [dbo].[OwnerProperty] op ON  p.Id = op.PropertyId 
INNER JOIN [Keys].[dbo].[TenantProperty] tp ON p.Id = tp.PropertyId
INNER JOIN [dbo].[TenantPaymentFrequencies] tpf ON tpf.Id = tp.PaymentFrequencyId
INNER JOIN [dbo].[Tenant] t ON tp.TenantId = t.Id
INNER JOIN [dbo].[Person] pe ON t.Id = pe.Id
WHERE op.OwnerId = 1426