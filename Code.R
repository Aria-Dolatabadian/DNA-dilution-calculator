library(shiny)

# Define UI
ui <- fluidPage(
  titlePanel("DNA Dilution Calculator"),
  sidebarLayout(
    sidebarPanel(
      numericInput("initial_concentration", "Initial DNA Concentration (ng/µl):", value = 0),
      numericInput("desired_concentration", "Desired Final DNA Concentration (ng/µl):", value = 0),
      numericInput("final_volume", "Final Volume (µl):", value = 0),
      actionButton("calculate", "Calculate")
    ),
    mainPanel(
      textOutput("dna_output"),
      textOutput("water_output")
    )
  )
)

# Define server
server <- function(input, output) {
  observeEvent(input$calculate, {
    # Get input values
    initial_concentration <- input$initial_concentration
    desired_concentration <- input$desired_concentration
    final_volume <- input$final_volume
    
    # Calculate the dilution factor
    dilution_factor <- initial_concentration / desired_concentration
    
    # Calculate the volume of DNA and water needed for dilution
    volume_dna <- final_volume / dilution_factor
    volume_water <- final_volume - volume_dna
    
    # Display the results
    output$dna_output <- renderText(paste("Volume of DNA needed:", volume_dna, "µl"))
    output$water_output <- renderText(paste("Volume of water needed:", volume_water, "µl"))
  })
}

# Run the app
shinyApp(ui = ui, server = server)
