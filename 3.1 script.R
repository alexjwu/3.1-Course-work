library(readxl)
refine_original_csv <- read_excel("refine_original.csv.xlsx")
df2 <- refine_original_csv %>% mutate(company = ifelse(grepl("^phil|^fil|^phl", company, ignore.case = TRUE), "phillips", company)) %>% mutate(company = ifelse(grepl("^ak", company, ignore.case = TRUE), "akzo", company)) %>% mutate(company = ifelse(grepl("^van", company, ignore.case = TRUE), "van_houten", company)) %>% mutate(company = ifelse(grepl("^uni", company, ignore.case = TRUE), "unilever", company))
df2 <- df2 %>% separate(`Product code / number`, c("product code", "product number"), sep = "-")
df2 <- df2 %>% mutate(`product category` = ifelse(`product code` == "p", "smartphone", ifelse(`product code` == "v", "tv", ifelse(`product code` == "x", "laptop", ifelse(`product code` == "q", "tablet", "product code")))))
df2 <- df2 %>% unite(full_address, address, city, country, sep = ", ")
df2 <- df2 %>% mutate(`company_akzo` = ifelse(`company` == "akzo", "1", "0")) %>% mutate(`company_phillips` = ifelse(`company` == "phillips", "1", "0")) %>% mutate(`company_van_houten` = ifelse(`company` == "van houten", "1", "0")) %>% mutate(`company_unilever` = ifelse(`company` == "unilever", "1", "0"))
write.table(df2, file="refine_clean",sep=",",row.names=F)


