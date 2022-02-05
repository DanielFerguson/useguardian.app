import { Fragment } from 'react'
import { Popover, Transition } from '@headlessui/react'
import { MenuIcon, XIcon } from '@heroicons/react/outline'

const navigation = [
    { name: 'Features', href: '#features' },
    { name: 'Case Study', href: '#case-study' },
    { name: 'For Business', href: '/business' },
    { name: 'For Government', href: '/government' },
];

export default function Hero() {
    return (
        <div id="sign-up" className="relative bg-white overflow-hidden">
            <div className="hidden lg:block lg:absolute lg:inset-0" aria-hidden="true">
                <svg
                    className="absolute top-0 left-1/2 transform translate-x-64 -translate-y-8"
                    width={640}
                    height={784}
                    fill="none"
                    viewBox="0 0 640 784"
                >
                    <defs>
                        <pattern
                            id="9ebea6f4-a1f5-4d96-8c4e-4c2abf658047"
                            x={118}
                            y={0}
                            width={20}
                            height={20}
                            patternUnits="userSpaceOnUse"
                        >
                            <rect x={0} y={0} width={4} height={4} className="text-gray-200" fill="currentColor" />
                        </pattern>
                    </defs>
                    <rect y={72} width={640} height={640} className="text-gray-50" fill="currentColor" />
                    <rect x={118} width={404} height={784} fill="url(#9ebea6f4-a1f5-4d96-8c4e-4c2abf658047)" />
                </svg>
            </div>

            <div className="relative pt-6 pb-16 sm:pb-24 lg:pb-32">
                <Popover>
                    <nav
                        className="relative max-w-7xl mx-auto flex items-center justify-between px-4 sm:px-6"
                        aria-label="Global"
                    >
                        <div className="flex items-center flex-1">
                            <div className="flex items-center justify-between w-full md:w-auto">
                                <a href="#">
                                    <span className="sr-only">Workflow</span>
                                    <img
                                        className="h-8 w-auto sm:h-10"
                                        src="/guardian.svg"
                                        alt=""
                                    />
                                </a>
                                <div className="-mr-2 flex items-center md:hidden">
                                    <Popover.Button className="bg-white rounded-md p-2 inline-flex items-center justify-center text-gray-400 hover:text-gray-500 hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-inset focus:ring-blue-500">
                                        <span className="sr-only">Open main menu</span>
                                        <MenuIcon className="h-6 w-6" aria-hidden="true" />
                                    </Popover.Button>
                                </div>
                            </div>
                            <div className="hidden md:block md:ml-10 md:space-x-10">
                                {navigation.map((item) => (
                                    <a key={item.name} href={item.href} className="font-medium text-gray-500 hover:text-gray-900">
                                        {item.name}
                                    </a>
                                ))}
                                {/* <a href="#sign-up" className="font-medium text-blue-600 hover:text-gray-900">Sign Up</a> */}
                            </div>
                        </div>
                    </nav>

                    <Transition
                        as={Fragment}
                        enter="duration-150 ease-out"
                        enterFrom="opacity-0 scale-95"
                        enterTo="opacity-100 scale-100"
                        leave="duration-100 ease-in"
                        leaveFrom="opacity-100 scale-100"
                        leaveTo="opacity-0 scale-95"
                    >
                        <Popover.Panel
                            focus
                            className="absolute z-10 top-0 inset-x-0 p-2 transition transform origin-top-right md:hidden"
                        >
                            <div className="rounded-lg shadow-md bg-white ring-1 ring-black ring-opacity-5 overflow-hidden">
                                <div className="px-5 pt-4 flex items-center justify-between">
                                    <div>
                                        <img
                                            className="h-8 w-auto"
                                            src="/guardian.svg"
                                            alt=""
                                        />
                                    </div>
                                    <div className="-mr-2">
                                        <Popover.Button className="bg-white rounded-md p-2 inline-flex items-center justify-center text-gray-400 hover:text-gray-500 hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-inset focus:ring-blue-500">
                                            <span className="sr-only">Close main menu</span>
                                            <XIcon className="h-6 w-6" aria-hidden="true" />
                                        </Popover.Button>
                                    </div>
                                </div>
                                <div className="px-2 pt-2 pb-3 space-y-1">
                                    {navigation.map((item) => (
                                        <a
                                            key={item.name}
                                            href={item.href}
                                            className="block px-3 py-2 rounded-md text-base font-medium text-gray-700 hover:text-gray-900 hover:bg-gray-50"
                                        >
                                            {item.name}
                                        </a>
                                    ))}
                                    {/* <a href="#sign-up" className="block px-3 py-2 rounded-md text-base font-medium text-blue-700 hover:text-gray-900 hover:bg-gray-50">Sign Up</a> */}
                                </div>
                            </div>
                        </Popover.Panel>
                    </Transition>
                </Popover>

                <main className="mt-16 mx-auto max-w-7xl px-4 sm:mt-24 sm:px-6 lg:mt-32">
                    <div className="lg:grid lg:grid-cols-12 lg:gap-8">
                        <div className="sm:text-center md:max-w-2xl md:mx-auto lg:col-span-6 lg:text-left">
                            <h1>
                                <span className="block text-sm font-semibold uppercase tracking-wide text-gray-500 sm:text-base lg:text-sm xl:text-base">
                                    Coming soon
                                </span>
                                <span className="mt-1 block text-4xl tracking-tight font-extrabold sm:text-5xl xl:text-6xl">
                                    <span className="block text-gray-900">Privacy-first</span>
                                    <span className="block text-blue-600">instant contact tracing.</span>
                                </span>
                            </h1>
                            <p className="mt-3 text-base text-gray-500 sm:mt-5 sm:text-xl lg:text-lg xl:text-xl">
                                A privacy-first cross-platform contact-tracing application, automating near-immediate results
                                and helping to prevent further COVID-19 outbreaks.
                            </p>
                            <div className="mt-8 sm:max-w-lg sm:mx-auto sm:text-center lg:text-left lg:mx-0">
                                <p className="text-base font-medium text-gray-900">Sign up to get notified when it’s ready.</p>
                                <form action="https://formspree.io/f/xbjqebpy" method="POST" className="mt-3 sm:flex">
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
                        </div>
                        <div className="mt-12 relative sm:max-w-lg w-max lg:mt-0 mx-auto lg:col-span-6 lg:flex lg:items-center">
                            <div className="device device-iphone-x" style={{ "fontSize": "0.75px" }}>
                                <div className="device-frame">
                                    <video className="device-content" muted autoPlay loop>
                                        <source src="/video.mp4" type="video/mp4" />
                                    </video>
                                </div>
                                <div className="device-stripe"></div>
                                <div className="device-header"></div>
                                <div className="device-sensors"></div>
                                <div className="device-btns"></div>
                                <div className="device-power"></div>
                                <div className="device-home"></div>
                            </div>
                        </div>
                    </div>
                </main>
            </div >
        </div >
    );
}