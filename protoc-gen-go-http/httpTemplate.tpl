{{$svrType := .ServiceType}}
{{$svrName := .ServiceName}}

{{- range .MethodSets}}
const Operation{{$svrType}}{{.OriginalName}} = "/{{$svrName}}/{{.OriginalName}}"
{{- end}}

type {{.ServiceType}}HTTPServer interface {
{{- range .MethodSets}}
	{{- if ne .Comment ""}}
	{{.Comment}}
	{{- end}}
	{{.Name}}(context.Context, *{{.Request}}) (*{{.Reply}}, error)
{{- end}}
}

func Register{{.ServiceType}}HTTPServer(s *gin.Engine, handleFunc gin.HandlerFunc, srv {{.ServiceType}}HTTPServer) {
	r := s.Group("/"{{- if .Token }}, handleFunc{{- end }})
	{{- range .Methods}}
	r.{{.Method}}("{{.Path}}",{{- if .Token }}handleFunc, {{- end}} _{{$svrType}}_{{.Name}}{{.Num}}_HTTP_Handler(srv))
	{{- end}}
}

{{range .Methods}}
func _{{$svrType}}_{{.Name}}{{.Num}}_HTTP_Handler(srv {{$svrType}}HTTPServer) func(ctx *gin.Context) {
	return func(ctx *gin.Context) {
		var in {{.Request}}
		{{- if .HasBody}}
		if err := ctx.Bind(&in{{.Body}}); err != nil {
			return
		}
		{{- end}}
		if err := ctx.BindQuery(&in); err != nil {
			return
		}
		{{- if .HasVars}}
		if err := ctx.BindVars(&in); err != nil {
			return
		}
		{{- end}}
		out, err := srv.{{.Name}}(ctx, &in)
		if err != nil {
		    ctx.JSON(500, err)
			return
		}
		reply := out
		ctx.JSON(200, reply{{.ResponseBody}})
		return
	}
}
{{end}}
