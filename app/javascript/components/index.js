import React from 'react'
import ReactDOM from 'react-dom'
import PublicationCard from './PublicationCard'
import PublicationSummary from './PublicationSummary'
import PublicationsFeed from './PublicationsFeed'
// Example publication card component

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
            case 'PublicationSummary':
                ReactDOM.render(
                    <PublicationSummary {...props} />,
                    element
                )
                break
            case 'PublicationsFeed':
                ReactDOM.render(
                    <PublicationsFeed {...props} />,
                    element
                )
                break
            // Add more components here
        }
    })
})