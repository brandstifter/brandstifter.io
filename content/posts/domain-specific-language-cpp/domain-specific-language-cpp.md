---
title: "Domain specific language in C++"
date: 2018-12-20
slug: "domain-specific-language-cpp"
tags: ["Design Pattern", "Builder Pattern",  "HTML"]
categories: ["C++", "Domain specific language"]
header_image: "posts/domain-specific-language-cpp"/img/leave.jpg"
---

The beauty of Voronoi
=====================

## Motivation


    HTMLBuilder builder("ul"};
    builder
        .add_child("li", "hello")
        .add_child("li", "world")

    std::cout << builder.str() << std::endl;


## Solution

    class HTMLElement
    {
        std::string name, text;
        std::vector<HTMLElement> elements;
        const size_t indent_size = 4;

        HTMLElement() {}

        HTMLElement(const std::string &name, const std::string &text) : name(name), text(text) {}


    public:
        string str(insigned long indent = 0) const 
        {
            std::ostringstream oss;
            string ii (ident_size * ident, ' ');
            oss << ii << "<" << name << ">" << text << std::endl;

            for (const auto& element : elements)
                oss << element.str(indent + 1);

            oss << ii << "</" << name << ">" << std::endl;s
            return oss.str();
        }
    }

    struct HTMLBuilder 
    {
        HTMLElement (string root_name)
        {
            root.name = root_name;
        }

    }
