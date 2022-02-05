import Document, { Html, Head, Main, NextScript } from 'next/document'

class MyDocument extends Document {
    render() {
        return (
            <Html className="h-full">
                <Head>
                    <link rel="shortcut icon" href="/favicon.ico" />
                    <link href="https://fonts.googleapis.com/css2?family=Inter&display=optional" rel="stylesheet" />
                </Head>
                <body className="h-full">
                    <Main />
                    <NextScript />
                </body>
            </Html>
        )
    }
}

export default MyDocument