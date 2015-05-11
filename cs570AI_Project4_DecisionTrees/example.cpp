struct attrItem 
{
    std::vector<int>  itemNum;  //itemNum[0] = itemLine.size()
                                //itemNum[1] = decision num
    set<int>          itemLine;
};
 
struct attributes
{
    string attriName;
    vector<double> statResult;
    map<string, attrItem*> attriItem;
}; 
vector<attributes*> statTree;

struct TreeNode 
{
    std::string               m_sAttribute;
    int                       m_iDeciNum;
    int                       m_iUnDecinum;
    std::vector<TreeNode*>    m_vChildren;    
};

#include "DecisionTree.h"
 
int main(int argc, char* argv[]){
    string filename = "source.txt";
    DecisionTree dt ;
    int attr_node = 0;
    TreeNode* treeHead = nullptr;
    set<int> readLineNum;
    vector<int> readClumNum;
    int deep = 0;
    if (dt.pretreatment(filename, readLineNum, readClumNum) == 0)
        {
            dt.CreatTree(treeHead, dt.getStatTree(), dt.getInfos(), readLineNum, readClumNum, deep);
        }
    return 0;
}

int DecisionTree::pretreatment(string filename, set<int>& readLineNum, vector<int>& readClumNum)
{
    ifstream read(filename.c_str());
    string itemline = "";
    getline(read, itemline);
    istringstream iss(itemline);
    string attr = "";
    while(iss >> attr)
        {
            attributes* s_attr = new attributes();
            s_attr->attriName = attr;
            statTree.push_back(s_attr);
            attr_clum[attr] = attriNum;
            attriNum++;
            readClumNum.push_back(0);
            s_attr = nullptr;
        }
 
    int i  = 0;
    while(true)
        {
            getline(read, itemline);
            if(itemline == "" || itemline.length() <= 1)
                {
                    break;
                }
            vector<string> infoline;
            istringstream stream(itemline);
            string item = "";
            while(stream >> item)
                {
                    infoline.push_back(item);
                }
 
            infos.push_back(infoline);
            readLineNum.insert(i);
            i++;
        }
    read.close();
    return 0;
}
 
int DecisionTree::statister(vector<vector<string>>& infos, vector<attributes*>& statTree, 
                            set<int>& readLine, vector<int>& readClumNum)
{
    int deciNum = 0;
    set<int>::iterator iter_end = readLine.end();
    for (set<int>::iterator line_iter = readLine.begin(); line_iter != iter_end; ++line_iter)
        {
            bool decisLine = false;
            if (infos[*line_iter][attriNum - 1] == "yes")
                {
                    decisLine = true;
                    deciNum++; 
                }
            for (int i = 0; i < attriNum - 1; i++)
                {
                    if (readClumNum[i] == 0)
                        {
                            std::string tempitem = infos[*line_iter][i];
                            auto map_iter = statTree[i]->attriItem.find(tempitem);
                            if (map_iter == (statTree[i]->attriItem).end())
                                {
                                    attrItem* attritem = new attrItem();
                                    attritem->itemNum.push_back(1);
                                    decisLine ? attritem->itemNum.push_back(1) : attritem->itemNum.push_back(0);
                                    attritem->itemLine.insert(*line_iter);
                                    (statTree[i]->attriItem)[tempitem] = attritem;
                                    attritem = nullptr;
                                }
                            else
                                {
                                    (map_iter->second)->itemNum[0]++;
                                    (map_iter->second)->itemLine.insert(*line_iter);
                                    if(decisLine)
                                        {
                                            (map_iter->second)->itemNum[1]++;
                                        }
                                }
                        }
                }
        }
    return deciNum;
}
 
void DecisionTree::CreatTree(TreeNode* treeHead, vector<attributes*>& statTree, vector<vector<string>>& infos, 
                             set<int>& readLine, vector<int>& readClumNum, int deep)
{
    if (readLine.size() != 0)
        {
            string treeLine = "";
            for (int i = 0; i < deep; i++)
                {
                    treeLine += "--";
                }
            resetStatTree(statTree, readClumNum);
            int deciNum = statister(getInfos(), statTree, readLine, readClumNum);
            int lineNum = readLine.size();
            int attr_node = compuDecisiNote(statTree, deciNum, lineNum, readClumNum);//本条复制为局部变量
            readClumNum[attr_node] = 1;
            TreeNode* treeNote = new TreeNode();
            treeNote->m_sAttribute = statTree[attr_node]->attriName;
            treeNote->m_iDeciNum = deciNum;
            treeNote->m_iUnDecinum = lineNum - deciNum;
            if (treeHead == nullptr)
                {
                    treeHead = treeNote; //树根
                }
            else
                {
                    treeHead->m_vChildren.push_back(treeNote); //子节点
                }
            cout << "节点-"<< treeLine << ">" << statTree[attr_node]->attriName    << endl;
         
            for(map<string, attrItem*>::iterator map_iterator = statTree[attr_node]->attriItem.begin();
                map_iterator != statTree[attr_node]->attriItem.end(); ++map_iterator)
                {
                    int sum = map_iterator->second->itemNum[0];
                    int deci_Num = map_iterator->second->itemNum[1];
                    cout << "分支--"<< treeLine << ">" << map_iterator->first << endl;
                    if (deci_Num != 0 && sum != deci_Num )
                        {
                            set<int> newReadLineNum = map_iterator->second->itemLine;
                            //DFS
                            CreatTree(treeNote, statTree, infos, newReadLineNum, readClumNum, deep + 1);
                        }
                    else
                        {
                            TreeNode* treeEnd = new TreeNode();
                            treeEnd->m_sAttribute = statTree[attr_node]->attriName;
                            treeEnd->m_iDeciNum = deci_Num;
                            treeEnd->m_iUnDecinum = sum - deci_Num;
                            treeNote->m_vChildren.push_back(treeEnd);
                            //打印叶子
                            if (deci_Num == 0)
                                {
                                    cout << "叶子---"<< treeLine << ">no" << endl;
                                }
                            else
                                {
                                    cout << "叶子---"<< treeLine << ">yes" << endl;
                                }
                        }
                }
            readClumNum[attr_node] = 0;
        }
}

int DecisionTree::compuDecisiNote(vector<attributes*>& statTree, int deciNum, int lineNum, vector<int>& readClumNum)
{
    double max_temp = 0;
    int max_attribute = 0;
    double infoD = info_D(deciNum, lineNum);
    for (int i = 0; i < attriNum - 1; i++)
        {
            if (readClumNum[i] == 0)
                {
                    double splitInfo = 0.0;
                    //info
                    double info_temp = Info_attr(statTree[i]->attriItem, splitInfo, lineNum);
                    statTree[i]->statResult.push_back(info_temp);
                    //gain
                    double gain_temp = infoD - info_temp;
                    statTree[i]->statResult.push_back(gain_temp);
                    //split_info
                    statTree[i]->statResult.push_back(splitInfo);
                    //gain_info
                    double temp = gain_temp / splitInfo;
                    statTree[i]->statResult.push_back(temp);
                    if (temp > max_temp)
                        {
                            max_temp = temp;
                            max_attribute = i;
                        }
                }
        }
    return max_attribute;
}

double DecisionTree::info_D(int deciNum, int sum)
{
    double pi = (double)deciNum / (double)sum;
    double result = 0.0;
    if (pi == 1.0 || pi == 0.0)
        {
            return result;
        }
    result = pi * (log(pi) / log((double)2)) + (1 - pi)*(log(1 - pi)/log((double)2));
    return -result;
}

double DecisionTree::Info_attr(map<string, attrItem*>& attriItem, double& splitInfo, int lineNum)
{
    double result = 0.0;
    for (map<string, attrItem*>::iterator item = attriItem.begin();
         item != attriItem.end();
         ++item
         )
        {
            double pi = (double)(item->second->itemNum[0]) / (double)lineNum;
            splitInfo += pi * (log(pi) / log((double)2));
            double sub_attr = info_D(item->second->itemNum[1], item->second->itemNum[0]);
            result += pi * sub_attr;
        }
    splitInfo = -splitInfo;
    return result;
}

void DecisionTree::resetStatTree(vector<attributes*>& statTree, vector<int>& readClumNum)
{
    for (int i = 0; i < readClumNum.size() - 1; i++)
        {
            if (readClumNum[i] == 0)
                {
                    map<string, attrItem*>::iterator it_end = statTree[i]->attriItem.end();
                    for (map<string, attrItem*>::iterator it = statTree[i]->attriItem.begin();
                         it != it_end; it++)
                        {
                            delete it->second;
                        }
                    statTree[i]->attriItem.clear();
                    statTree[i]->statResult.clear();
                }
        }
}
