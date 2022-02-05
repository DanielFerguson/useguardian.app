import Head from 'next/head'
import Link from 'next/link'

export default function Government() {
    return (
        <>
            <Head>
                <meta name="description" content="A privacy-first cross-platform contact-tracing application, automating near-immediate results and helping to prevent further COVID-19 outbreaks." />
                <meta name="keywords" content="privacy,privacy-first,cross-platform,contact-tracing,contact,tracing,application,automate,automating,prevent,COVID-19,outbreaks,lockdown,lockdowns" />
            </Head>
            <div className="min-h-full pt-16 pb-12 flex flex-col bg-white items-center">
                <main className="flex-grow flex flex-col justify-center max-w-7xl w-full mx-auto px-4 sm:px-6 lg:px-8">
                    <div className="flex-shrink-0 flex justify-center">
                        <Link href="/">
                            <a className="inline-flex">
                                <span className="sr-only">Workflow</span>
                                <img
                                    className="h-12 w-auto"
                                    src="/guardian.svg"
                                    alt=""
                                />
                            </a>
                        </Link>
                    </div>
                    <div className="py-16">
                        <div className="text-center flex flex-col items-center">
                            <p className="text-sm font-semibold text-indigo-600 uppercase tracking-wide">Coming soon</p>
                            <h1 className="mt-2 text-4xl font-extrabold text-gray-900 tracking-tight sm:text-5xl">Guardian for Government</h1>
                            <p className="mt-4 text-base text-gray-500 max-w-2xl mx-auto">COVID-19 one of the most difficult challenges we have had to face, but Guardian makes protecting our population not only possible, but manageable. We&apos;re creating a page specifically to help you understand how Guardian can improve your contact tracing, but integrate with and to expontentially improve your existing systems and services.</p>
                            <div className="mt-8 sm:max-w-lg sm:mx-auto sm:text-center lg:text-left lg:mx-0 mx-auto">
                                <p className="text-base font-medium text-gray-900">Be notified when it’s ready.</p>
                                <form action="https://formspree.io/f/xgerbqrw" method="POST" className="mt-3 w-96 sm:flex">
                                    <label htmlFor="email" className="sr-only">
                                        Email
                                    </label>
                                    <input
                                        type="text"
                                        name="email"
                                        id="email"
                                        className="block w-full py-3 text-base rounded-md placeholder-gray-500 shadow-sm focus:ring-blue-500 focus:border-blue-500 sm:flex-1 border-gray-300"
                                        placeholder="Enter your email"
                                    />
                                    <button
                                        type="submit"
                                        className="mt-3 w-full px-6 py-3 border border-transparent text-base font-medium rounded-md text-white bg-gray-800 shadow-sm hover:bg-gray-900 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 sm:mt-0 sm:ml-3 sm:flex-shrink-0 sm:inline-flex sm:items-center sm:w-auto"
                                    >
                                        Notify me
                                    </button>
                                </form>
                            </div>
                            <div className="mt-6">
                                <Link href="/">
                                    <a className="text-base font-medium text-indigo-600 hover:text-indigo-500">
                                        Go back home<span aria-hidden="true"> &rarr;</span>
                                    </a>
                                </Link>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </>
    )
}