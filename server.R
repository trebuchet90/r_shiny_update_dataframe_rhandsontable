
library(rhandsontable)

shinyServer(function(input, output, session) {
  values = reactiveValues()
  
  data = reactive({
    if (!is.null(input$hot)) {
      DF = hot_to_r(input$hot)
    } else {
      if (is.null(values[["DF"]]))
        DF = data.frame(int_var = 0, 
                        date_var = Sys.Date(), 
                        string_var = "",
                        stringsAsFactors = F)
      else
        DF = values[["DF"]]
    }
    
    
    values[["DF"]] = DF
    DF
  })
  
  output$hot <- renderRHandsontable({
    DF = data()
    if (!is.null(DF))
      rhandsontable(DF, useTypes = as.logical(input$useType), stretchH = "all")
  })
  
  output$tdisplay <- renderDataTable({
    input$update
    isolate(data())
  })
  
})
