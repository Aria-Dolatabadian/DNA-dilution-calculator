library(shiny)

# Define UI
ui <- fluidPage(
  titlePanel("DNA Dilution Calculator"),
  sidebarLayout(
    sidebarPanel(
      numericInput("sample_number", "Sample Number:", value = 1, min = 1, max = 10),
      numericInput("initial_concentration", "Initial DNA Concentration (ng/µl):", value = 0),
      numericInput("desired_concentration", "Desired Final DNA Concentration (ng/µl):", value = 0),
      numericInput("final_volume", "Final Volume (µl):", value = 0),
      actionButton("calculate", "Calculate"),
      downloadButton("export", "Export Results as CSV")
    ),
    mainPanel(
      textOutput("dna_output"),
      textOutput("water_output"),
      tableOutput("results_table")
    )
  )
)

# Define server
server <- function(input, output, session) {
  results <- reactiveValues(data = data.frame())
  
  observeEvent(input$calculate, {
    # Get input values
    sample_number <- input$sample_number
    initial_concentration <- input$initial_concentration
    desired_concentration <- input$desired_concentration
    final_volume <- input$final_volume
    
    # Calculate the dilution factor
    dilution_factor <- initial_concentration / desired_concentration
    
    # Calculate the volume of DNA and water needed for dilution
    volume_dna <- final_volume / dilution_factor
    volume_water <- final_volume - volume_dna
    
    # Create a data frame for the current calculation
    result <- data.frame(
      Sample_Number = sample_number,
      DNA_Volume = volume_dna,
      Water_Volume = volume_water
    )
    
    # Add the current calculation to the results data frame
    results$data <- rbind(results$data, result)
  })
  
  output$dna_output <- renderText({
    paste("Volume of DNA needed:", results$data$DNA_Volume, "µl")
  })
  
  output$water_output <- renderText({
    paste("Volume of water needed:", results$data$Water_Volume, "µl")
  })
  
  output$results_table <- renderTable({
    results$data
  })
  
  output$export <- downloadHandler(
    filename = "results.csv",
    content = function(file) {
      write.csv(results$data, file, row.names = FALSE)
    }
  )
}

# Run the app
shinyApp(ui = ui, server = server)
