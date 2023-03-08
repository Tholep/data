# Define the named pipe name
$pipeName = "TestPipe"



# Create a named pipe server
$pipe = New-Object System.IO.Pipes.NamedPipeServerStream($pipeName, [System.IO.Pipes.PipeDirection]::InOut)


Write-Host "Server is waiting for connection..."

# Start listening for client connections
$pipe.WaitForConnection()


# Create a StreamReader and StreamWriter for the named pipe
$reader = New-Object System.IO.StreamReader($pipe)
$writer = New-Object System.IO.StreamWriter($pipe)

# Loop to read messages from the client and respond
while($true) {
    # Read a message from the client
    $message = $reader.ReadLine()


    # Check if the client has disconnected
    if($message -eq "kill") {
        Write-Host "Server closed"
        break
    }

    if ($message) {
        # Display the message received from the client
        Write-Host "Server received message: $message"
        # Prompt the server user for a response message
        $response = Read-Host "Enter response to client message"

        # Send the response message to the client
        $writer.WriteLine($response)
        $writer.Flush()
    }
}

# Clean up resources
$reader.Close()
$writer.Close()
$pipe.Dispose()
