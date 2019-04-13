# csvparse

*Parses CSV data into a JSON object or array of objects.*

### Usage

    {% assign data = csvurl | csvparse: options %}

### Parameters

- `csvurl` string. required. The URL to the CSV file.
- `options` string. optional. comma separated. List of additional properties to transform returned results.
    - `headers_convert` CSV headers are converted from **Column Title** to **column_title**, otherwise defaults to **Column Title**.
    - `array` Returns an array of objects, each row is a new object. Otherwise defaults to single object, each row is a new child object with the key from column 1.

### Return

- json|array. The data from the CSV file will return as an array of JSON objects or JSON object.

## **Example**

---

### Input

    {% assign default_example = site._data[data] | csvparse %}
    {% assign headers_convert_example = site._data[data] | csvparse: "headers_convert" %}
    {% assign array_example = site._data[data] | csvparse: "array" %}
    {% assign array_headers_convert_example = site._data[data] | csvparse: "array,headers_convert" %}

### **Output**

    default_example
    
    {
      22: {
        "ID": "22",
        "Rank": "1",
        "Name": "South Dakota State University",
        "Location": "Brookings, South Dakota",
        "Study Area": "Bachelors in Science",
        "URL": "https://www.sdstate.edu/online-graduate-degrees"
      },
      ...
    }
    
    headers_convert_example
    
    {
      22: {
        "id": "22",
        "rank": "1",
        "name": "South Dakota State University",
        "location": "Brookings, South Dakota",
        "study_area": "Bachelors in Science",
        "url": "https://www.sdstate.edu/online-graduate-degrees"
      },
      ...
    }
    
    array_example
    
    [
      {
        "ID": "1",
        "Rank": "1",
        "Name": "South Dakota State University",
         "Location": "Brookings, South Dakota",
        "Study Area": "Bachelors in Science",
        "URL": "https://www.sdstate.edu/online-graduate-degrees"
      },
      ...
    ]
    
    array_headers_convert_example
    
    [
      {
        "id": "1",
        "rank": "1",
        "name": "South Dakota State University",
        "location": "Brookings, South Dakota",
        "study_area": "Bachelors in Science",
        "url": "https://www.sdstate.edu/online-graduate-degrees"
      },
      ...
    ]
