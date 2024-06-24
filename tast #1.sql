-- Обчислення NPS в розрізі категорій
SELECT
    ir."CATEGORY_CD" AS category,
    COUNT(*) AS total_responses,
    SUM(CASE WHEN ir."NPS" >= 9 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS promoters_percentage,
    SUM(CASE WHEN ir."NPS" <= 6 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS detractors_percentage,
    (SUM(CASE WHEN ir."NPS" >= 9 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) - SUM(CASE WHEN ir."NPS" <= 6 THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) AS nps
FROM
    "ivr_result" ir
LEFT JOIN
    "dict_regions" dr ON ir."PhoneTo" = dr."PhoneTo"
LEFT JOIN
    "dict_device" dd ON ir."PhoneTo" = dd."PhoneTo"
GROUP BY
    ir."CATEGORY_CD";
	
	
-- Обчислення NPS в поденній динаміці
SELECT
    ir."date",
    COUNT(*) AS total_responses,
    SUM(CASE WHEN ir."NPS" >= 9 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS promoters_percentage,
    SUM(CASE WHEN ir."NPS" <= 6 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS detractors_percentage,
    (SUM(CASE WHEN ir."NPS" >= 9 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) - SUM(CASE WHEN ir."NPS" <= 6 THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) AS nps
FROM
    "ivr_result" ir
GROUP BY
    ir."date";
	
-- в поденній динаміці в розрізі категорій	
SELECT
    ir."date",
    ir."CATEGORY_CD" AS category,
    COUNT(*) AS total_responses,
    SUM(CASE WHEN ir."NPS" >= 9 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS promoters_percentage,
    SUM(CASE WHEN ir."NPS" <= 6 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS detractors_percentage,
    (SUM(CASE WHEN ir."NPS" >= 9 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) - SUM(CASE WHEN ir."NPS" <= 6 THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) AS nps
FROM
    "ivr_result" ir
GROUP BY
    ir."date", ir."CATEGORY_CD";
	
	
-- Отримання агрегованих даних щодо кількості скарг в розрізі регіонів та 	пристроїв в поденній динаміці
SELECT
    ir."date",
    dr."Region",
    dd."Region" AS device_os,
    COUNT(*) AS total_complaints
FROM
    "ivr_result" ir
LEFT JOIN
    "dict_regions" dr ON ir."PhoneTo" = dr."PhoneTo"
LEFT JOIN
    "dict_device" dd ON ir."PhoneTo" = dd."PhoneTo"

GROUP BY
    ir."date", dr."Region", dd."Region";