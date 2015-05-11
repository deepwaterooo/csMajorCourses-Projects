package com.eyecm.tree;

/**
 * 树上每个节点存放的数据
 * 
 */
public class NodeData
{
    private String username;
    private String content;

    public NodeData()
    {

    }

    public NodeData(String username, String content)
    {
        this.username = username;
        this.content = content;
    }

    public void output()
    {
        System.out.println(username + " " + content);
    }
}
