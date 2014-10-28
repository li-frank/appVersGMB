#setwd("C:/Users/frankli/Dropbox (eBayMob&Eng)/FrankL/Rproj/GMB_appVers")

#install.packages('RJDBC')
#install.packages('plyr')
#install.packages("C:/Users/frankli/Downloads/ebaytd_1.1.tar.gz", repos = NULL, type = "source", lib="C:/Program Files/R/R-3.1.1/library")

############################################
library('ebaytd')
library('plyr')

c <- teradataConnect()

############################
# #Hardcoded SQL
# sql<-"
# SELECT
#   co.created_dt,
#   /*co.trans_site_id,*/
# CASE	WHEN apps.app_id IS NULL AND sess_cobrand IN 7 THEN 'FSoM'		
# WHEN apps.app_id IS  NULL THEN 'Core Site on PC'
# WHEN TRIM(apps.prdct_name) IN 'IPhoneApp' THEN 'iPhone App'
# WHEN TRIM(apps.prdct_name) IN ('Android','Android Motors') THEN 'AndroidApp'
# WHEN TRIM(apps.prdct_name) IN 'IPad' THEN 'iPad App'
# WHEN TRIM(apps.prdct_name) IN ('MobWeb','MobWebGXO') THEN 'Mobile Web'
# ELSE 'Other'
# END Platform,		
# appVersion,--delete if skewed out
# 
# CASE	WHEN buyer_country_id IN  (1, -1, 0, -999, 225, 679, 1000) THEN 'US'		
# WHEN buyer_country_id IN 3 THEN 'UK'
# WHEN buyer_country_id IN 77 THEN 'DE'
# WHEN buyer_country_id IN 15 THEN 'AU'
# WHEN buyer_country_id IN 2 THEN 'CA'
# ELSE 'Other'
# END buyer_country,		
# 
# SUM(CAST(co.item_price * co.quantity * CAST(cr.CURNCY_PLAN_RATE AS FLOAT) AS DECIMAL(18,2))) AS gmb_plan			
# 
# FROM		
# (
# select 
# created_dt,
# sess_cobrand,
# buyer_id,
# quantity,
# item_price,
# lstg_curncy_id,
# leaf_categ_id,
# app_id,
# item_site_id,
# buyer_country_id,
# sojlib.soj_nvl(SESS_EVENT_DETAILS,'mav') appVersion
# 
# from p_soj_cl_v.checkout_metric_item
# 
# where
# created_dt BETWEEN current_date-30 AND current_date-1
# AND auct_end_dt >= current_date-30
# AND ck_wacko_yn = 'N'
# AND auct_type_code NOT IN (12,15)			
# ) co	
# 
# INNER JOIN access_views.ssa_curncy_plan_rate_dim cr ON (co.lstg_curncy_id = cr.curncy_id)
# INNER JOIN access_views.dw_category_groupings cat ON (co.leaf_categ_id = cat.leaf_categ_id AND co.item_site_id = cat.site_id)
# LEFT JOIN access_views.dw_api_mbl_app apps ON (co.app_id = apps.app_id)
# 
# WHERE		
# /*	AND app.app_id IS NOT NULL*/
# cat.sap_category_id NOT IN (5,7,23,41)
# 
# GROUP BY		
# 1,2,3,4;
# "
# df <- dbGetQuery(c,sql)

###########################

sqlPath <- 'C:/Users/frankli/Dropbox (eBayMob&Eng)/FrankL/Rproj/GMB_appVers/GMB_appVers_Date.sql'
sqlQuery <- paste(readLines(sqlPath), collapse=" ")
df <- dbGetQuery(c,sqlQuery)

# sqlfile <- gsub("\t"," ",sqlfile)
# sqlfile <- gsub(""," ",sqlfile)
# df2 <- dbSendQuery(c,sqlfile)