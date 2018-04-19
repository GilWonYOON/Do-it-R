class(welfare$religion)
table(welfare$religion)

welfare$religion <- ifelse(welfare$religion == 1, "Yes","No")
table(welfare$religion)
qplot(welfare$religion)
table(welfare$marriage)
welfare$group_marriage <- ifelse(welfare$marriage == 1,"Marriage",
                                 ifelse(welfare$marriage == 3,"divorce", NA))
table(welfare$group_marriage)
table(is.na(welfare$group_marriage))
qplot(welfare$group_marriage) # 그래프 나타내기

#종합적으로 나타내기 ? -- 종교 유무에 따른 이혼률 조사 
religion_marriage <- welfare %>%
    filter(!is.na(group_marriage)) %>%          #marrige의 na 값 제거 
    group_by(religion, group_marriage) %>%      #같은 값들은 묶어서 계산 
    summarise(n = n()) %>%                      #총 갯수 계산
    mutate(tot_group = sum(n)) %>%              #새로운 변수를 만들어서 저장  
    mutate(pct = round(n/tot_group*100, 1))     #비율로 환산해서 계산 

religion_marriage
