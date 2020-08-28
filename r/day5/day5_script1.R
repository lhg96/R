#����ġ ǥ�� - �빮�� NA
df <- data.frame(gender = c("M", "F", NA, "M", "F"),  
                    score = c(5, 4, 3, 4, NA))
df

is.na(df)	# ����ġ Ȯ��  table(is.na(df))		# ����ġ �� ���

#�������� ����ġ Ȯ���ϱ�
table(is.na(df$gender))	# gender ����ġ �� ���  
table(is.na(df$score))	# score ����ġ �� ���

#����ġ ���Ե� ���·� �м�  
mean(df$score)		# ��� ����  
sum(df$score)	# �հ� ����

#����ġ �� �����ϱ�  
library(dplyr) # dplyr ��Ű�� �ε�
df %>% filter(is.na(score))	# score�� NA�� �����͸� ���

df %>% filter(!is.na(score))	# score ����ġ ����  
#����ġ ������ �����ͷ� �м��ϱ�
df_perfect  <- df %>% filter(!is.na(score))	# score ����ġ ����  
df_perfect

# score, gender ����ġ ����
df_perfect <- df %>% filter(!is.na(score) & !is.na(gender))  
df_perfect

#����ġ�� �ϳ��� ������ �����ϱ�
df_perfect1 <- na.omit(df)	# ��� ������ ����ġ ���� ������ ����  
mean(df_perfect1$score, na.rm = T)
mean(df$score, na.rm = T)

#�̻�ġ(outlier) ����
outlier <- data.frame(gender = c(1, 2, 1, 3, 2, 1),
score = c(5, 4, 3, 4, 2, 6))
outlier

#�̻�ġ Ȯ���ϱ�  table(outlier$score)

#���� ó���ϱ� - gennder(3�̸� NA �Ҵ�)
outlier$gender <- ifelse(outlier$gender == 3, NA, outlier$gender)
outlier

#�̻�ġ Ȯ���ϱ�  
table(outlier$gender)  
table(outlier$score)

#���� ó���ϱ� - gender  
#gender�� 3�̸� NA �Ҵ�
outlier$gender <- ifelse(outlier$gender == 3, NA, outlier$gender)
outlier

#���� ó���ϱ� - score
# score�� 1~5 �ƴϸ� NA �Ҵ�
outlier$score <- ifelse(outlier$score > 5, NA, outlier$score)  
outlier

#����ġ �����ϰ� �м�  outlier %>%
filter(!is.na(gender) & !is.na(score)) %>%  
group_by(gender) %>%  
summarise(mean_score = mean(score))

#�̻�ġ Ȯ���ϱ�  
table(outlier$gender)  
table(outlier$score)

#���� ó���ϱ� - gender  
#gender�� 3�̸� NA �Ҵ�
outlier$gender <- ifelse(outlier$gender == 3, NA, outlier$gender)
outlier

#���� ó���ϱ� - score
# score�� 1~5 �ƴϸ� NA �Ҵ�
outlier$score <- ifelse(outlier$score > 5, NA, outlier$score)  
outlier

#����ġ �����ϰ� �м�  outlier %>%
filter(!is.na(gender) & !is.na(score)) %>%  
group_by(gender) %>%  
summarise(mean_score = mean(score))

#�̻�ġ �����ϱ�  #���ڱ׸� ����
mpg <- as.data.frame(ggplot2::mpg)
boxplot(mpg$hwy)

#���ڱ׸� ���ġ ���  boxplot(mpg$hwy)
boxplot(mpg$hwy)$stats	# ���ڱ׸� ���ġ ���  boxplot(mpg$hwy)$stats[5,]

#���� ó���ϱ�
# 12~37 ����� NA �Ҵ�
mpg$hwy <- ifelse(mpg$hwy < 12 | mpg$hwy > 37, NA, mpg$hwy)  
table(is.na(mpg$hwy))

#����ġ �����ϰ� �м��ϱ�  mpg %>%
group_by(drv) %>%
summarise(mean_hwy = mean(hwy, na.rm = T))