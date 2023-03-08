# Define the named pipe name
$pipeName = "TestPipe"

$serverName = "commando"
# Create a named pipe client
$pipe = New-Object System.IO.Pipes.NamedPipeClientStream($serverName, $pipeName, [System.IO.Pipes.PipeDirection]::InOut)

# Connect to the named pipe server
$pipe.Connect()

# Create a StreamReader and StreamWriter for the named pipe
$reader = New-Object System.IO.StreamReader($pipe)
$writer = New-Object System.IO.StreamWriter($pipe)

# Loop to read input from the user and send messages to the server
while($true) {
    # Prompt the user for a message to send to the server
    $message = Read-Host "Enter message to send to server"

    # Send the message to the server
    $writer.WriteLine($message)
    $writer.Flush()

    # Read the response from the server
    $response = $reader.ReadLine()

    
    # Check if the server has disconnected
    if($message -eq "kill") {
        break
    }

    # Display the response from the server
    Write-Host "Client received response: $response"

}

# Clean up resources
$reader.Close()
$writer.Close()
$pipe.Dispose()
