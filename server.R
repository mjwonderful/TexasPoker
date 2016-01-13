library(shiny)
library(ggplot2)
library(dplyr)

score <- read.csv(file="score.csv")
score9 <- filter(score,场次==9)
a <-   score9$分数

shinyServer(function(input, output) {
  
  output$plot1 <- renderPlot({
   ggplot(score,aes(场次,分数,group=玩家姓名))+
      geom_point(aes(color=玩家姓名))+
      geom_line(aes(color=玩家姓名))+
      facet_wrap(~玩家姓名)+
      theme_bw()+
      labs(x="场次",y="I+积分",title="德州玩家分数趋势")+
      theme(legend.position = "none") 
  })
  output$plot2 <- renderPlot({ 
    ggplot(score9,aes(玩家姓名,分数,fill=玩家姓名))+
      geom_bar(stat="identity")+theme(legend.position = "none")+
      geom_text(aes(label = a, vjust =-0.4, hjust =0.5, size=0.4, angle = 0, show_guide = FALSE))+
      labs(x=NULL,y="I+积分",title="最新分数分布")+
      theme(axis.text.x=element_text(angle=90,hjust=1,size=12,color="black"))
  })

}
)