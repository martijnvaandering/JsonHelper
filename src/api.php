<?php
header('Content-Type: application/json');

// Alleen POST-verzoeken verwerken
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $rawInput = file_get_contents('php://input');
    $queryString = $_SERVER['QUERY_STRING'] ?? '';
    parse_str($queryString, $params);

    // URL-decoderen van parameters
    foreach ($params as $key => $value) {
        $params[$key] = urldecode($value);
    }

    if (isset($params['q'])) {
        $jqQuery = escapeshellarg($params['q']);
        $cmd = "echo " . escapeshellarg($rawInput) . " | jq -r $jqQuery 2>&1";
        $output = shell_exec($cmd);
        echo $output;
        exit;
    }

    if (isset($params['select'])) {
        $selectKeys = explode(',', $params['select']);
        $jqFilter = '[.[] | {';
        $jqFilter .= implode(', ', array_map(fn($k) => "$k: .$k", $selectKeys));
        $jqFilter .= '}]';

        $cmd = "echo " . escapeshellarg($rawInput) . " | jq -r " . escapeshellarg($jqFilter) . " 2>&1";
        $output = shell_exec($cmd);
        echo $output;
        exit;
    }

    http_response_code(400);
    echo json_encode(['error' => 'No valid query parameters provided.']);
    exit;
}

// Voor GET of andere methodes
header('Content-Type: text/plain');
echo "yo";
