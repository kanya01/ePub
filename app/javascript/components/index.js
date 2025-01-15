import React from 'react'
import ReactDOM from 'react-dom'

// Example publication card component
const PublicationCard = ({ title, excerpt, category }) => {
    return (
        <div className="bg-white shadow-lg rounded-lg overflow-hidden">
            <div className="p-6">
                <div className="text-xs font-semibold text-blue-600 uppercase tracking-wide">
                    {category}
                </div>
                <h3 className="mt-2 text-xl font-semibold">{title}</h3>
                <p className="mt-3 text-base text-gray-500">{excerpt}</p>
                <div className="mt-4">
                    <a href="#" className="text-blue-600 hover:text-blue-700">
                        Read More
                    </a>
                </div>
            </div>
        </div>
    )
}

// Mount React components when the page loads
document.addEventListener('turbo:load', () => {
    const elements = document.querySelectorAll('[data-react-component]')

    elements.forEach(element => {
        const componentName = element.dataset.reactComponent
        const props = JSON.parse(element.dataset.reactProps || '{}')

        switch(componentName) {
            case 'PublicationCard':
                ReactDOM.render(
                    <PublicationCard {...props} />,
                    element
                )
                break
            // Add more components here
        }
    })
})