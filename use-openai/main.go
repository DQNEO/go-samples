package main

import (
	"context"
	"fmt"
	"os"

	openai "github.com/sashabaranov/go-openai"
)

func main() {
	CreateChatCompletion()
	CreateCompletion()
	CreateTranscription()
}

var client = openai.NewClient(os.Getenv("OPENAI_API_KEY"))

func CreateTranscription() {
	ctx := context.Background()
	if len(os.Args) < 2 {
		panic("Please specify an audio file")
	}
	audioFilePath := os.Args[1]

	req := openai.AudioRequest{
		Model:    openai.Whisper1,
		FilePath: audioFilePath,
	}
	resp, err := client.CreateTranscription(ctx, req)
	if err != nil {
		fmt.Printf("Transcription error: %v\n", err)
		return
	}
	fmt.Println(resp.Text)
}

func CreateCompletion() {
	fmt.Printf("CreateCompletion: ")
	ctx := context.Background()

	req := openai.CompletionRequest{
		Model:     openai.GPT3Ada,
		MaxTokens: 5,
		Prompt:    "Lorem ipsum",
	}
	resp, err := client.CreateCompletion(ctx, req)
	if err != nil {
		fmt.Printf("Completion error: %v\n", err)
		return
	}
	fmt.Println(resp.Choices[0].Text)
}

func CreateChatCompletion() {
	fmt.Printf("CreateChatCompletion: ")

	ctx := context.Background()
	resp, err := client.CreateChatCompletion(
		ctx,
		openai.ChatCompletionRequest{
			Model: openai.GPT3Dot5Turbo,
			Messages: []openai.ChatCompletionMessage{
				{
					Role:    openai.ChatMessageRoleUser,
					Content: "Hello!",
				},
			},
		},
	)

	if err != nil {
		fmt.Printf("ChatCompletion error: %v\n", err)
		return
	}

	fmt.Println(resp.Choices[0].Message.Content)
}
