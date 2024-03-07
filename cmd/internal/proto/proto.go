package proto

import (
	"github.com/honlyc/openim-cmdline/cmd/internal/proto/client"
	"github.com/spf13/cobra"
)

// CmdProto represents the proto command.
var CmdProto = &cobra.Command{
	Use:   "proto",
	Short: "Generate the proto files",
	Long:  "Generate the proto files.",
}

func init() {
	CmdProto.AddCommand(client.CmdClient)
}
