const path = require('path')

require("esbuild").build({
    entryPoints: ["application.js"],
    bundle: true,
    outdir: path.join(process.cwd(), "app/assets/builds"),
    absWorkingDir: path.join(process.cwd(), "app/javascript"),
    loader: {
        '.js': 'jsx',
        '.jsx': 'jsx'
    },
    resolve: {
        extensions: ['.js', '.jsx', '.ts', '.tsx']
    }
}).catch(() => process.exit(1))