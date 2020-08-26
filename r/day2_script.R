library(dplyr)
library(ggplot2)

df <- data.frame(var1 = c(4,3,8), var2=c(2,6,1))
df

df$var_sum <- df$var1 + df$var2
df
df$var_mean <- (df$var1 + df$var2)/2
df

mpg2$total <- (mpg2$cty + mpg2$hwy)/2
head(mpg2)
head(mpg)

summary(mpg2$total)
hist(mpg2$total)
mpg2$test <- ifelse(mpg2$total >= 20, "pass", "fail")
head(mpg2, 20)
table(mpg2$test)
qplot(mpg2$test)

mpg2$grade <- ifelse(mpg2$total>=30, "A", 
                     ifelse(mpg2$total>=20, "B", "C"))
table(mpg2$grade)
qplot(mpg2$grade)

library(dplyr)
exam <- read.csv("csv_exam.csv")
exam

#-------------------------------------------
# filter() : ���ǿ� �´� ������ �����ϱ�
#-------------------------------------------

exam %>% filter(class == 1)
exam %>% filter(class == 2)
exam %>% filter(class != 1)
exam %>% filter(class != 3)
exam %>% filter(math > 50)
exam %>% filter(math < 50)


exam %>% filter(english >= 80)
exam %>% filter(english < 80)
exam %>% filter(class == 1 & math >= 50)
exam %>% filter(class == 2 & english >= 80)
exam %>% filter(math >= 90 | english >= 90)
exam %>% filter(english < 90 | science < 50)

#matching operator, %in% : 
#������ ���� ������ ���� ��Ͽ� �ش��ϴ��� Ȯ��

exam %>% filter(class == 1 | class == 3 | class == 5)
exam %>% filter(class %in% c(1, 3, 5))



#1�ݰ� 2���� ������ �� ���� ����������� ���ϱ�

class1 <- exam %>% filter(class == 1)
class2 <- exam %>% filter(class == 2)
mean(class1$math)
mean(class2$math)

dplyr::glimpse(mpg)   #str(mpg)

# Q1
displ.4 <- mpg %>%  filter(displ <= 4)
displ.5 <- mpg %>%  filter(displ >= 5)
mean(displ.4$hwy)
mean(displ.5$hwy)

# Q2
audi <- mpg %>% filter(manufacturer == "audi")
toyota <- mpg %>% filter(manufacturer == "toyota")
mean(audi$cty)
mean(toyota$cty)

# Q3
manu.3 <- mpg %>% filter(manufacturer %in% c("chevrolet", "ford", "honda"))
mean(manu.3$hwy)

#----------------------------------------------
# select() : �ʿ��� ������ �����ϱ�
#----------------------------------------------

exam %>% select(math)
exam %>% select(class, math, english)
exam %>% select(-math)
exam %>% filter(class ==1) %>% select(english)

exam %>%
  filter(class == 1) %>%
  select(english)

exam %>%
  select(id, math) %>%
  head

# Q1
mpg <- as.data.frame(ggplot2::mpg)
mpg %>% select(class, cty) %>% head

mpg_1 <- mpg %>% select(class, cty)

# Q2
mpg_suv <- mpg_1 %>% filter(class == "suv")
mpg_com <- mpg_1 %>% filter(class == "compact")

mean(mpg_suv$cty)
mean(mpg_com$cty)

#--------------------------------------------------
# arrange() : ������(��) ������
#--------------------------------------------------

exam %>% arrange(math)
exam %>% arrange(desc(math))
exam %>% arrange(class, math)

mpg_audi <- mpg %>% filter(manufacturer == "audi")
mpg_audi %>% arrange(desc(hwy)) %>% head(5)

#---------------------------------------------------
# mutate() : ���� �������� �Լ��� ���ο� ������ ����
#---------------------------------------------------
exam %>% 
  mutate(total = math + english + science) %>% 
  head

exam %>% 
  mutate(total = math + english + science, mean = (math + english + science)/3) %>% 
  head

exam %>% 
  mutate(test = ifelse(science >=60, "pass", "fail")) %>% 
  head

exam %>% 
  mutate(total = math + english + science) %>% 
  arrange(desc(total)) %>% 
  head

# mpg �����ʹ� ���� ��Ÿ���� ������ hwy(���ӵ��� ����), cty(���� ����) �� ������ �и��Ǿ� �ֽ��ϴ�.
# �� ������ ���� Ȱ���ϴ� ��� �ϳ��� ���տ��� ������ ����� �м��Ϸ��� �մϴ�.
# Q1. mpg() ������ ���纻�� ����� cty�� hwy�� ���� ���ջ꿬�� �������� �߰��ϼ���.

mpg_total <- mpg %>% mutate(total = cty + hwy)
head(mpg_total)


# Q2. �տ��� ���� ���ջ꿬�� ������ �� 2�� ���� ����տ��� ������ �� �߰��ϼ���.

mpg_total <- mpg %>% mutate(total = cty + hwy, mean = total/2)
head(mpg_total)


# Q3. ����տ��񺯼����� ���� ���� �ڵ��� 3���� �����͸� ����ϼ���.

mpg_view <- mpg_total %>% arrange(desc(mean)) %>% head(3)
View(mpg_view)

# Q4. 1~3�� ������ �ذ��� �� �ִ� �ϳ��� ����� dplyr ������ ����� ����ϼ���.
# �����ʹ� ���纻 ��� mpg ������ �̿��ϼ���.

mpg %>% mutate(total = cty + hwy, mean = total/2) %>% 
  arrange(desc(mean)) %>% 
  head(3)

#-------------------------------------------------
# group by() : ���� ���� ����ϱ�
#-------------------------------------------------

exam %>% summarise(mean_math = mean(math))

exam %>% 
  group_by(class) %>% 
  summarise(mean_math = mean(math))

# ���� ��� ��跮 �ѹ��� ����ϱ�
exam %>%
  group_by(class) %>%
  summarise(mean_math = mean(math), 
            sum_math = sum(math),
            median_math = median(math),
            n = n())               #n()�� �����Ͱ� �� ������ �Ǿ� �ִ��� ���󵵡��� ���ϴ� ���

mpg %>%
  group_by(manufacturer, drv) %>%
  summarise(mean_city = mean(cty)) %>% 
  head(10)

mpg %>% 
  group_by(manufacturer) %>% 
  filter(class == "suv") %>% 
  mutate(mean = (cty + hwy)/2) %>% 
  arrange(desc(mean)) %>% 
  head(5)

# Q1.

mpg <- as.data.frame(ggplot2::mpg)

mpg %>%
  group_by(class) %>%
  summarise(mean_city = mean(cty))

# Q2.

mpg %>%
  group_by(class) %>%
  summarise(mean_city = mean(cty)) %>% 
  arrange(desc(mean_city))

# Q3.
mpg %>%
  group_by(manufacturer) %>%
  summarise(mean_hwy = mean(hwy)) %>% 
  arrange(desc(mean_hwy)) %>% 
  head(3)

# Q4.
mpg %>%
  group_by(manufacturer) %>% 
  filter(class == "compact") %>%
  summarise(count = n()) %>% 
  arrange(desc(count))


# ���η� ������ ��ġ�� : left_join() �Լ� �̿�, �������� ���� �������� by �� ����, ������ �յڿ� ����ǥ �Է�

test1 <- data.frame(id = c(1, 2, 3, 4, 5), midterm = c(60, 80, 70, 90, 85))
test2 <- data.frame(id = c(1, 2, 3, 4, 5), final = c(70, 83, 65, 95, 80))
test1
test2

total <- left_join(test1, test2, by = "id")
total

name <- data.frame(class = c(1, 2, 3, 4, 5), 
                   teacher = c("kim", "lee", "park", "choi", "jung"))
name

exam <- read.csv("csv_exam.csv")
exam_name <- left_join(exam, name, by = "class")
exam_name


# ���η� ��ġ��
group_a <- data.frame(id = c(1, 2, 3, 4, 5),
                      test = c(60, 80, 70, 90, 85))
group_b <- data.frame(id = c(1, 2, 3, 4, 5),
                      test = c(70, 83, 65, 95, 80))
group_a

# bind_rows() �� �̿�, �����͸� ���η� ��ħ, �������� �ٸ��� rename()���� �����ϰ� ���� �� ��ħ.
group_all <- bind_rows(group_a, group_b)
group_all


##  mpg ����

fuel <- data.frame(fl = c("c", "d", "e", "p", "r"),
                   price_fl = c(2.35, 2.38, 2.11, 2.76, 2.22),
                   stringsAsFactors = F)
fuel


# Q1.
mpg_new <- left_join(mpg, fuel, by = "fl")

# Q2.
mpg_new %>%
  select(model, fl, price_fl)%>%
  head(5)