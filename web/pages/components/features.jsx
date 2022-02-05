import {
    EyeOffIcon,
    FastForwardIcon,
    CursorClickIcon,
    ShieldCheckIcon,
    RefreshIcon,
    ServerIcon,
} from '@heroicons/react/outline'

const features = [
    { name: 'Privacy-first', icon: EyeOffIcon, description: 'Location data stays on your device, encrypted. We don\'t store it on our servers, or anyone elses.' },
    { name: 'Instant', icon: FastForwardIcon, description: 'When exposure sites are updated, your device will check to see whether you need to isolate, instantly.' },
    { name: 'Set & Forget', icon: CursorClickIcon, description: 'No need to remember scan in and out of bars, resturants and gyms; start tracking and live your life.' },
    { name: 'Secure', icon: ShieldCheckIcon, description: 'Your data stays on your phone, encrypted. No remote servers to be hacked, no way for data to get leaked.' },
];

export default function Features() {
    return (
        <div id="features" className="relative bg-white">
            <div className="mx-auto max-w-md px-4 text-center sm:max-w-3xl sm:px-6 lg:px-8 lg:max-w-7xl">
                <h2 className="text-base font-semibold tracking-wider text-blue-600 uppercase">Get notified faster</h2>
                <p className="mt-2 text-3xl font-extrabold text-gray-900 tracking-tight sm:text-4xl">
                    1, 5, 10-step contact tracing in a single day
                </p>
                <p className="mt-5 max-w-2xl mx-auto text-xl text-gray-500">
                    As different strains of COVID-19 appear, we need to implement systems to stay ahead of the curve; so we can stay open and save lifes.
                </p>
                <div className="mt-12">
                    <div className="grid grid-cols-1 gap-8 sm:grid-cols-2 lg:grid-cols-4">
                        {features.map((feature) => (
                            <div key={feature.name} className="pt-6">
                                <div className="flow-root bg-gray-50 rounded-lg px-6 pb-8">
                                    <div className="-mt-6">
                                        <div>
                                            <span className="inline-flex items-center justify-center p-3 bg-blue-500 rounded-md shadow-lg">
                                                <feature.icon className="h-6 w-6 text-white" aria-hidden="true" />
                                            </span>
                                        </div>
                                        <h3 className="mt-8 text-lg font-medium text-gray-900 tracking-tight">{feature.name}</h3>
                                        <p className="mt-5 text-base text-gray-500">{feature.description}</p>
                                    </div>
                                </div>
                            </div>
                        ))}
                    </div>
                </div>
            </div>
        </div>
    );
}