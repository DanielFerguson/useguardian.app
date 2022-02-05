export default function CallToAction() {
    return (
        <div className="bg-white">
            <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div className="bg-blue-700 rounded-lg shadow-xl overflow-hidden lg:grid lg:grid-cols-2 lg:gap-4">
                    <div className="pt-10 pb-12 px-6 sm:pt-16 sm:px-16 lg:py-16 lg:pr-0 xl:py-20 xl:px-20">
                        <div className="lg:self-center">
                            <h2 className="text-3xl font-extrabold text-white sm:text-4xl">
                                <span className="block">Ready for a solution?</span>
                                <span className="block">Sign up for Guardian.</span>
                            </h2>
                            <p className="mt-4 text-lg leading-6 text-blue-200">
                                We&apos;re working around the clock in order to build Guardian into a future-proof solution to help break us out of the lockdown-cycle, open up the economy and save lives.
                            </p>
                            <a
                                href="#sign-up"
                                className="mt-8 bg-white border border-transparent rounded-md shadow px-5 py-3 inline-flex items-center text-base font-medium text-blue-600 hover:bg-blue-50"
                            >
                                Be notified when we launch
                            </a>
                        </div>
                    </div>
                    <div className="-mt-6 aspect-w-5 aspect-h-3 md:aspect-w-2 md:aspect-h-1">
                        <video autoPlay loop className="mt-auto border-4 border-b-0 border-gray-900 rounded-2xl rounded-b-none mx-auto" style={{ width: 'auto', height: '80%' }}>
                            <source src="/replay.mp4" />
                        </video>
                    </div>
                </div>
            </div>
        </div>
    );
}