const faqs = [
    {
        question: 'How do you make holy water? 1',
        answer:
            'You boil the hell out of it. Lorem ipsum dolor sit amet consectetur adipisicing elit. Quas cupiditate laboriosam fugiat.',
    },
    {
        question: 'How do you make holy water? 2',
        answer:
            'You boil the hell out of it. Lorem ipsum dolor sit amet consectetur adipisicing elit. Quas cupiditate laboriosam fugiat.',
    },
    {
        question: 'How do you make holy water? 3',
        answer:
            'You boil the hell out of it. Lorem ipsum dolor sit amet consectetur adipisicing elit. Quas cupiditate laboriosam fugiat.',
    },
    {
        question: 'How do you make holy water? 4',
        answer:
            'You boil the hell out of it. Lorem ipsum dolor sit amet consectetur adipisicing elit. Quas cupiditate laboriosam fugiat.',
    },
];

export default function FAQs() {
    return (
        <div id="faqs" className="bg-white">
            <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div className="lg:grid lg:grid-cols-3 lg:gap-8">
                    <div>
                        <h2 className="text-3xl font-extrabold text-gray-900">Frequently asked questions</h2>
                        <p className="mt-4 text-lg text-gray-500">
                            Can’t find the answer you’re looking for? Reach out to our{' '}
                            <a href="#" className="font-medium text-blue-600 hover:text-blue-500">
                                customer support
                            </a>{' '}
                            team.
                        </p>
                    </div>
                    <div className="mt-12 lg:mt-0 lg:col-span-2">
                        <dl className="space-y-12">
                            {faqs.map((faq) => (
                                <div key={faq.question}>
                                    <dt className="text-lg leading-6 font-medium text-gray-900">{faq.question}</dt>
                                    <dd className="mt-2 text-base text-gray-500">{faq.answer}</dd>
                                </div>
                            ))}
                        </dl>
                    </div>
                </div>
            </div>
        </div>
    );
}