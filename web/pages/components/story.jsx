import { CameraIcon } from '@heroicons/react/solid'

export default function Story() {
    return (
        <div id="case-study" className="relative bg-white">
            <div className="lg:absolute lg:inset-0">
                <div className="lg:absolute lg:inset-y-0 lg:left-0 lg:w-1/2">
                    <img
                        className="h-56 w-full object-cover lg:absolute lg:h-full"
                        src="https://images.unsplash.com/photo-1581803118522-7b72a50f7e9f?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=687&q=80"
                        alt="Joe in a downtown street"
                    />
                </div>
            </div>
            <div className="relative pt-12 pb-16 px-4 sm:pt-16 sm:px-6 lg:px-8 lg:max-w-7xl lg:mx-auto lg:grid lg:grid-cols-2">
                <div className="lg:col-start-2 lg:pl-8">
                    <div className="text-base max-w-prose mx-auto lg:max-w-lg lg:ml-auto lg:mr-0">
                        <h2 className="leading-6 text-indigo-600 font-semibold tracking-wide uppercase">Case Study</h2>
                        <h3 className="mt-2 text-3xl leading-8 font-extrabold tracking-tight text-gray-900 sm:text-4xl">
                            Meet Joe
                        </h3>
                        <p className="mt-8 text-lg text-gray-500">
                            Joe has just been contacted by the Department of Health who have spent the last 3 days identifying him as a potential contact.
                        </p>
                        <p className="mt-4 text-lg text-gray-500">
                            He goes and gets a COVID test. He’s positive, and he’s been in the community for days; <b>unknowingly infecting others.</b>
                        </p>
                        <h3 className="mt-8 text-3xl leading-8 font-extrabold tracking-tight text-gray-900 sm:text-4xl">
                            Now follow Joe with Guardian.
                        </h3>
                        <p className="mt-4 text-lg text-gray-500">
                            Joe has just received a Guardian
                            alert on his phone telling him he
                            has been in the same place at
                            the same time as someone who
                            has just tested positive for
                            COVID.
                        </p>
                        <p className="mt-4 text-lg text-gray-500 ">
                            He <span className="font-bold">immediately gets tested</span> and heads home to
                            isolate, reducing the likelihood or possibility for community transmission and helping Joe to recover and <span className="font-bold">faster than ever.</span>
                        </p>
                        {/* <p>
                                After getting a positive test result,
                                Joe submits his data, and everyone
                                who he’s had contact with who
                                have the Guardian app installed
                                are now also getting tested. Joe’s
                                movement data is also sent to the
                                Department of Health and Contact
                                Tracers are getting to work alerting
                                those who don’t have Guardian
                                and checking in on those who do.
                            </p> */}
                    </div>
                </div>
            </div>
        </div>
    );
}