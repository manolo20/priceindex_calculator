
rm(list=ls())

library(shiny)
#library(car)  
#library(readxl)
# library(tidyverse)
library(ggplot2)
library(plotly)


cpical <- readRDS("./data/cpicalc.rds")
cal <- readRDS("./data/calculator.rds")
cal<-cal %>% select(-Items)


cpi1<-cpical
for (i in 1:nrow(cpi1)){
 cpi1[i, "value"] <- round(((cpi1[i+12,"value"]/cpi1[i,"value"]-1)*100),1)  
}

cpi1 <- cpi1[1:119, "value"]
cpi1<-as.data.frame(cpi1)

la<-seq(as.Date('01/02/2008', format='%d/%m/%Y'), as.Date('01/12/2017', format='%d/%m/%Y'), 'months')


ui<-  shinyUI(fluidPage(
  titlePanel("Personal Price Index"),
  sidebarLayout(
    sidebarPanel(
      helpText("Enter your expenses below and your personal inflation rate chart will appear on the right. Expenses are monthly unless indicated otherwise."),            
      actionButton("actcalc", label = "Refresh & Calculate"),    
      downloadButton('downloadDataset', 'Download'),
      fluidRow(
        column(6, HTML('Groceries')),
        column(6, numericInput("num_principal1",
                   label = NULL,
                   value = 1000)
      )),
      fluidRow(
        column(6, HTML('Eating out (restaurants, etc):')),
        column(6, numericInput("num_principal2",
                   label = NULL,
                   value = 200)
        )),
      fluidRow(
        column(6, HTML('Rent:')),
        column(6, numericInput("num_principal3",
                   label = NULL,
                   value = 0)
        )),
      fluidRow(
        column(6, HTML('Mortgage interest payment:')),
        column(6, numericInput("num_principal4",
                   label = NULL,
                   value = 444)
        )),
      fluidRow(
        column(6, HTML('Purchase value of home (full amount, footnote 1):')),
        column(6, numericInput("num_principal5",
                   label = NULL,
                   value = 500000)
        )),
      fluidRow(
        column(6, HTML('Property taxes (annual):')),
        column(6, numericInput("num_principal6",
                   label = NULL,
                   value = 4000)
        )),
      fluidRow(
        column(6, HTML('Home and mortgage insurance:')),
        column(6, numericInput("num_principal7",
                   label = NULL,
                   value = 50)
         )),
      fluidRow(
        column(6, HTML('Home maintenance and repairs (annual):')),
        column(6, numericInput("num_principal8",
                   label = NULL,
                   value = 0)
               )),
     
      fluidRow(
        column(6, HTML('Electricity:')),
        column(6,numericInput("num_principal9",
                   label = NULL,
                   value = 100)
        )),
      fluidRow(
        column(6, HTML('Water:')),
        column(6, numericInput("num_principal10",
                   label = NULL,
                   value = 10)
        )),
      fluidRow(
        column(6, HTML('Natural gas:')),
        column(6,numericInput("num_principal11",
                   label = NULL,
                   value = 60)
        )),
      fluidRow(
        column(6, HTML('Home heating oil:')),
        column(6,numericInput("num_principal12",
                   label = NULL,
                   value = 0)
        )),
      fluidRow(
        column(6, HTML('Cellular phone service:')),
        column(6,numericInput("num_principal13",
                   label = NULL,
                   value = 300)
        )),
      fluidRow(
        column(6, HTML('Home internet service:')),
        column(6, numericInput("num_principal14",
                   label = NULL,
                   value = 150)
        )),
      fluidRow(
        column(6, HTML('Child care and housekeeping services:')),
        column(6,numericInput("num_principal15",
                   label = NULL,
                   value = 0)
        )),
      fluidRow(
        column(6, HTML('Home furnishings and equipment (annual):')),
        column(6, numericInput("num_principal16",
                   label = NULL,
                   value = 400)
        )),
      fluidRow(
        column(6, HTML('Clothing and footwear:')),
        column(6,numericInput("num_principal17",
                   label = NULL,
                   value = 200)
        )),
      fluidRow(
        column(6, HTML('Purchase of personal vehicle (full amount, footnote 2):')),
        column(6,numericInput("num_principal18",
                   label = NULL,
                   value = 30000)
        )),
      fluidRow(
        column(6, HTML('Gasoline:')),
        column(6,numericInput("num_principal19",
                   label = NULL,
                   value = 400)
        )),
      fluidRow(
        column(6, HTML('Personal vehicle parts, maintenance and repairs (annual):')),
        column(6,numericInput("num_principal20",
                   label = NULL,
                   value = 1000)
        )),
      fluidRow(
        column(6, HTML('Other personal vehicle expenses (parking, etc):')),
        column(6,numericInput("num_principal21",
                   label = NULL,
                   value = 70)
        )),
      fluidRow(
        column(6, HTML('Public transportation (bus, subway, etc):')),
        column(6,numericInput("num_principal22",
                   label = NULL,
                   value = 0)
        )),
      fluidRow(
        column(6, HTML('Airfare (annual):')),
        column(6,numericInput("num_principal23",
                   label = NULL,
                   value = 1200)
        )),
      fluidRow(
        column(6, HTML('Medicinal and pharmaceutical products:')),
        column(6,numericInput("num_principal24",
                   label = NULL,
                   value = 0)
        )),
      fluidRow(
        column(6, HTML('Digital computing equipment (annual):')),
        column(6,numericInput("num_principal25",
                   label = NULL,
                   value = 500)
        )),
      fluidRow(
        column(6, HTML('Hotels, motels, etc (annual):')),
        column(6,numericInput("num_principal26",
                   label = NULL,
                   value = 600)
        )),
      fluidRow(
        column(6, HTML('Travel tours (annual):')),
        column(6,numericInput("num_principal27",
                   label = NULL,
                   value = 0)
        )),
      fluidRow(
        column(6, HTML('Video and audio subscriptions (eg, Netflix):')),
        column(6,numericInput("num_principal28",
                   label = NULL,
                   value = 10)
        )),
      fluidRow(
        column(6, HTML('Alcohol:')),
        column(6,numericInput("num_principal29",
                   label = NULL,
                   value = 0)
        )),
      fluidRow(
        column(6, HTML('Cigarettes:')),
        column(6,numericInput("num_principal30",
                   label = NULL,
                   value = 0)
        )),
      
      br(),
      actionButton("actcalc", label = "Refresh & Calculate"), width = 6        
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Table",
                 tableOutput("result")
        ),
        tabPanel("Plot",
                 p(h4("About the Inflation Calculator:")),
                 plotlyOutput("myplot", height = "550px")
                 ),
        tabPanel("Documentation",
                 p(h4("Important Disclaimer:")),
                 HTML(#"<u><b>Disclaimer: </b></u>
                   "<br>Important Disclaimer: The Personal Inflation Rate provided here is for information purposes 
                    only and serves as only a proxy. It is not meant to be used as a substitute for the official
                    inflation rate, which is calculated to a much higher degree of accuracy. 
                    <br>
                    <br>
                    <b>Footnotes:</b> <br>
                    1: Enter the full value as of the latest property assessment.<br>
                    2: Enter the value of the full purchase price of car, less any discounts.
                    "))
                 ), width = 6
                 )
                 )
                 ))


server<-  shinyServer(function(input, output) { #, clientData, session
  
    addData <- reactiveValues()
    addData$dataset0 <- data.frame() #NULL
    
    observeEvent(input$actcalc,{
      
      # ASK about this loop in stackoverflow
      # mylist <- list()
      # for(i in 1:30){ 
      #   name<-noquote(paste0("input$num_principal", i ))
      #   mylist[[name]] <- name
      #   mylist<-noquote(unique(unlist(mylist)))
      #   mylist<-noquote(mylist)
      # }
      # 
      # for(i in 1:30){ 
      #   y<- mylist[i]*4
      #   assign(paste0("x", i),y)
      # }
      
      x1 <- input$num_principal1*cal[1,]
      x2 <- input$num_principal2*cal[2,]
      x3 <- input$num_principal3*cal[3,]
      x4 <- input$num_principal4*cal[4,]
      x5 <- input$num_principal5*cal[5,]*0.00125
      x6 <- input$num_principal6*cal[6,]/12
      x7 <- input$num_principal7*cal[7,]
      x8 <- input$num_principal8*cal[8,]
      x9 <- input$num_principal9*cal[9,]
      x10 <- input$num_principal10*cal[10,]
      x11 <- input$num_principal11*cal[11,]
      x12 <- input$num_principal12*cal[12,]
      x13 <- input$num_principal13*cal[13,]
      x14 <- input$num_principal14*cal[14,]
      x15 <- input$num_principal15*cal[15,]
      x16 <- input$num_principal16*cal[16,]/12
      x17 <- input$num_principal17*cal[17,]
      x18 <- input$num_principal18*cal[18,]/12
      x19 <- input$num_principal19*cal[19,]
      x20 <- input$num_principal20*cal[20,]/12
      x21 <- input$num_principal21*cal[21,]
      x22 <- input$num_principal22*cal[22,]
      x23 <- input$num_principal23*cal[23,]/12
      x24 <- input$num_principal24*cal[24,]
      x25 <- input$num_principal25*cal[25,]/12
      x26 <- input$num_principal26*cal[26,]/12
      x27 <- input$num_principal27*cal[27,]
      x28 <- input$num_principal28*cal[28,]
      x29 <- input$num_principal29*cal[29,]
      x30 <- input$num_principal30*cal[30,]

      
      cos <-  t(x1+ x2 + x3+ x4+ x5+ x6+ x7+ x8+ x9+ x10+ x11+ x12+ x13+ x14+ x15
              + x16+ x17+ x18+ x19+ x20+ x21+ x22+ x23+ x24+ x25+ x26+ x27+ x28+ x29+ x30)
      
      cosa<-as.data.frame(cos)
      for(i in 1:nrow(cosa)){               
        cosa[i,] <- cosa[i+1,]/cosa[i,]
      }
      
      tos<-cosa
      for(i in c(1:132)){
        tos[1,]<-cpical[1,]
        tos[i+1,]<-cosa[i,]*tos[i,]
      }
      
      tos<-tos[1:131,]
      tos<-as.data.frame(tos)

      final1 <- tos
        for(i in 1:nrow(final1)){
          final1[i,] <-round(((final1[i+12,]/final1[i,]-1)*100),1)
        }
        
        final1 <- final1[1:119,]
        final1 <- data.frame(cpi1, final1, la)        

        
        colnames(final1)<-c("Official CPI","Personal CPI", "Date") 
        
        final2<-final1
        final2$Date<-as.character(final2$Date)
      
      output$result <- renderTable({final2})    
      #newRow <- data.frame(final1)
      
      # THIS IS POINTLESS
      # final1$Date<-as.character(final1$Date)
      # final1$`Personal CPI`<-as.numeric(final1$`Personal CPI`)
      # final1$`Real CPI`<-as.numeric(final1$`Real CPI`)
      
      addData$dataset0 <- final1
      
      })
    
    
    output$downloadDataset <- downloadHandler(
      filename = function() {paste('Personal_CPI','.csv', sep='')},
      content = function(file) {write.table(addData$dataset0, dec = ",", sep = ";", row.names = FALSE, file)}
    ) 
    
    
    output$myplot <- renderPlotly({ggplotly( 
      # req(addData$dataset0)
      ggplot(addData$dataset0, aes(x=Date))+ #x=addData$dataset0$Date, 
        geom_line(aes(y=`Personal CPI`, color="Blue"))+
        geom_line(aes(y=`Official CPI`, color="Red"))+
        ylab("Annual CPI growth")+
        scale_colour_manual(labels = c("Personal CPI", "Official CPI"), values = c("blue", "red")))%>%
        layout(paper_bgcolor='white', plot_bgcolor='#ffffff',
               legend = list(
                 orientation = "h",
                 x = 0.5,
                 y = -0.2))
    })
    
    
})


shinyApp(ui = ui, server = server)
