___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "MACRO",
  "id": "cvt_tk_internal_traffic_flag",
  "version": 1,
  "displayName": "Internal Traffic Flag",
  "categories": [
    "UTILITY",
    "ANALYTICS"
  ],
  "description": "Flags likely internal or QA traffic using URL query parameters and optional host rules.",
  "containerContexts": [
    "WEB"
  ],
  "securityGroups": []
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "queryParameterName",
    "displayName": "Query Parameter Name",
    "simpleValueType": true,
    "defaultValue": "notrack",
    "help": "Query parameter used to flag internal traffic.",
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ]
  },
  {
    "type": "TEXT",
    "name": "queryParameterValue",
    "displayName": "Required Query Parameter Value",
    "simpleValueType": true,
    "help": "Optional. If provided, the query parameter must match this value to be treated as internal traffic.",
    "valueHint": "true"
  },
  {
    "type": "TEXT",
    "name": "hostMatches",
    "displayName": "Internal Host Matches",
    "simpleValueType": true,
    "help": "Optional comma-separated list of host fragments that should be treated as internal traffic.",
    "valueHint": "staging.example.com,qa.example.com,localhost"
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const getUrl = require('getUrl');
const getQueryParameters = require('getQueryParameters');
const getType = require('getType');
const makeString = require('makeString');

const normalize = function(value) {
  if (getType(value) !== 'string') return '';
  return makeString(value).trim().toLowerCase();
};

const splitList = function(value) {
  const normalized = normalize(value);
  if (!normalized) return [];
  return normalized.split(',').map(function(item) {
    return item.trim();
  }).filter(function(item) {
    return item.length > 0;
  });
};

const queryName = normalize(data.queryParameterName);
const requiredValue = normalize(data.queryParameterValue);
const host = normalize(getUrl('host'));
const queryValue = queryName ? normalize(getQueryParameters(queryName)) : '';

if (queryName && queryValue) {
  if (!requiredValue || queryValue === requiredValue) {
    return 'internal';
  }
}

const hostPatterns = splitList(data.hostMatches);
for (let i = 0; i < hostPatterns.length; i++) {
  if (host.indexOf(hostPatterns[i]) !== -1) {
    return 'internal';
  }
}

return 'external';


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "get_url",
        "versionId": "1"
      },
      "param": [
        {
          "key": "urlParts",
          "value": {
            "type": 1,
            "string": "any"
          }
        },
        {
          "key": "queriesAllowed",
          "value": {
            "type": 1,
            "string": "any"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios: []


___NOTES___

Community-ready template for flagging internal and QA traffic using client-side signals.
